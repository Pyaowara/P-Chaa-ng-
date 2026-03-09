import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/widgets/menu_detail/menu_detail_bottom_bar.dart';
import 'package:pchaa_flutter/widgets/menu_detail/menu_detail_content.dart';

class MenuDetailScreen extends StatefulWidget {
  final int menuId;
  const MenuDetailScreen({super.key, required this.menuId});

  @override
  State<MenuDetailScreen> createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  final bool _isShopOpen = isShopOpen;
  AvailableMenuItem? _menuDetail;
  bool _isLoading = false;
  String? _errorMsg;
  int _quantity = 1;
  final TextEditingController _messageController = TextEditingController();
  final Map<String, List<SelectedOption>> _selectedOptionsByGroup = {};
  double _addOnTotal = 0;

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

      final menuItems = await client.menuItem.getAvailableMenuItemById(widget.menuId);
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

  Set<String> _selectedNamesForGroup(AvailableCustomizationGroup group) {
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

  void _setSingleSelection(AvailableCustomizationGroup group, String? value) {
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

  void _setMultiSelection(AvailableCustomizationGroup group, Set<String> values) {
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
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("เพิ่มเข้าตะกร้าแล้ว"),
        ),
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: MenuDetailContent(
      menuDetail: _menuDetail,
      errorMsg: _errorMsg,
      messageController: _messageController,
      getSelectedNamesForGroup: _selectedNamesForGroup,
      onSingleChanged: (group, value) {
        setState(() {
          _setSingleSelection(group, value);
        });
      },
      onMultiChanged: (group, values) {
        setState(() {
          _setMultiSelection(group, values);
        });
      },
    ),
          ),
          bottomNavigationBar: MenuDetailBottomBar(
            isLogin: googleAuthService.isLoggedIn,
            isShopOpened: _isShopOpen,
            quantity: _quantity,
            onQuantityChanged: (value) {
              setState(() {
                _quantity = value;
              });
            },
            menuDetail: _menuDetail,
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
}
