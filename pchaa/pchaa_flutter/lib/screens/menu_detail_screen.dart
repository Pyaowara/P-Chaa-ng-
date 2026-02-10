import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/utils/url_utils.dart';
import 'package:pchaa_flutter/widgets/customization_choices.dart';

class MenuDetailScreen extends StatefulWidget {
  final int menuId;
  const MenuDetailScreen({super.key, required this.menuId});

  @override
  State<MenuDetailScreen> createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  bool _isShopOpen = isShopOpen;
  MenuItemWithUrl? _menuDetail;
  bool _isLoading = false;
  String? _errorMsg;
  int _quantity = 1;
  final TextEditingController _messageController = TextEditingController();
  final Map<String, List<SelectedOption>> _selectedOptionsByGroup = {};
  double _addOnTotal = 0;

  static const _imageHeight = 200.0;
  static const _primaryColor = Color(0xFF5A9CB5);

  @override
  void initState() {
    super.initState();
    _loadMenuDetail();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _loadMenuDetail() async {
    try {
      if (!mounted) return;
      setState(() {
        _isLoading = true;
        _errorMsg = null;
      });

      final menuItems = await client.menuItem.getMenuItemById(widget.menuId);
      debugPrint(menuItems.toString());
      if (!mounted) return;
      setState(() {
        _menuDetail = menuItems;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMsg = e.toString();
        _isLoading = false;
      });
    }
  }

  List<SelectedOption> _buildSelectedOptions() {
    return _selectedOptionsByGroup.values.expand((items) => items).toList();
  }

  Set<String> _selectedNamesForGroup(CustomizationGroup group) {
    final selected = _selectedOptionsByGroup[group.title] ?? [];
    return selected.map((item) => item.name).toSet();
  }

  void _recalculateAddOnTotal() {
    double total = 0;
    for (final options in _selectedOptionsByGroup.values) {
      for (final option in options) {
        total += option.price;
      }
    }
    _addOnTotal = total;
  }

  void _setSingleSelection(CustomizationGroup group, String? value) {
    if (value == null || value.isEmpty) {
      _selectedOptionsByGroup.remove(group.title);
      _recalculateAddOnTotal();
      return;
    }

    final choice = group.choices.firstWhere((c) => c.name == value);
    _selectedOptionsByGroup[group.title] = [
      SelectedOption(
        groupTitle: group.title,
        name: choice.name,
        price: choice.price,
      ),
    ];
    _recalculateAddOnTotal();
  }

  void _setMultiSelection(CustomizationGroup group, Set<String> values) {
    if (values.isEmpty) {
      _selectedOptionsByGroup.remove(group.title);
      _recalculateAddOnTotal();
      return;
    }

    final selected = group.choices
        .where((c) => values.contains(c.name))
        .map(
          (c) => SelectedOption(
            groupTitle: group.title,
            name: c.name,
            price: c.price,
          ),
        )
        .toList();
    _selectedOptionsByGroup[group.title] = selected;
    _recalculateAddOnTotal();
  }

  Future<void> _addToCart() async {
    if (_menuDetail == null) return;
    try {
      setState(() {
        _isLoading = true;
      });
      final selectedOptions = _buildSelectedOptions();
      await client.cart.createCart(
        widget.menuId,
        selectedOptions,
        _quantity,
        _messageController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("เพิ่มเข้าตะกร้าแล้ว"),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: _buildContent(_menuDetail),
          ),
          bottomNavigationBar: BottomBar(
            isShopOpened: _isShopOpen,
            quantity: _quantity,
            onQuantityChanged: (value) {
              setState(() {
                _quantity = value;
              });
            },
            addOnTotal: _addOnTotal,
            basePrice: _menuDetail?.basePrice ?? 0,
            onAddToCart: _menuDetail != null && _quantity > 0
                ? _addToCart
                : null,
            primaryColor: _primaryColor,
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.4),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent(MenuItemWithUrl? menuDetail) {
    if (_errorMsg != null) {
      return Center(child: Text(_errorMsg!));
    }
    if (menuDetail == null) {
      return const Center(child: Text("No Menu Detail"));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              top: 10,
              right: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menuDetail.name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Divider(),
                ),

                if (menuDetail.customization.isNotEmpty)
                  ...menuDetail.customization.map((customization) {
                    final selectedValues = _selectedNamesForGroup(
                      customization,
                    );
                    final selectedValue = selectedValues.isNotEmpty
                        ? selectedValues.first
                        : null;
                    return CustomizationChoices(
                      customizationGroup: customization,
                      selectedValue: selectedValue,
                      selectedValues: selectedValues,
                      onSingleChanged: (value) {
                        setState(() {
                          _setSingleSelection(customization, value);
                        });
                      },
                      onMultiChanged: (values) {
                        setState(() {
                          _setMultiSelection(customization, values);
                        });
                      },
                    );
                  }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Divider(),
                ),
                Text(
                  "เพิ่มเติม",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _messageController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'โน๊ตเพิ่มเติม',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final imageUrl = UrlUtils.getDisplayableImageUrl(_menuDetail?.imageUrl);
    final ImageProvider imageProvider = imageUrl.isEmpty
        ? const AssetImage("assets/images/food.jpg")
        : NetworkImage(imageUrl);
    return Stack(
      children: [
        Container(
          height: _imageHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: _imageHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.5),
              ],
            ),
            color: Colors.white,
          ),
        ),
        Positioned(
          top: 30,
          left: 10,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class BottomBar extends StatelessWidget {
  final int quantity;
  final bool isShopOpened;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback? onAddToCart;
  final double basePrice;
  final double addOnTotal;
  final Color primaryColor;
  const BottomBar({
    super.key,
    required this.isShopOpened,
    required this.quantity,
    required this.onQuantityChanged,
    required this.basePrice,
    required this.addOnTotal,
    required this.primaryColor,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final total = (basePrice + addOnTotal) * quantity;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.withValues(alpha: 1),
            width: 0.5,
          ),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: quantity > 1
                    ? () => onQuantityChanged(quantity - 1)
                    : null,
                icon: const Icon(Icons.remove),
                style: const ButtonStyle(),
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: () => onQuantityChanged(quantity + 1),
                icon: const Icon(Icons.add),
                style: const ButtonStyle(),
              ),
            ],
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: isShopOpened && quantity > 0 ? onAddToCart : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add To Cart",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    total.toStringAsFixed(2),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
