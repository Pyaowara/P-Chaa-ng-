import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/screens/cart_list.dart';
import 'package:pchaa_flutter/screens/menu_detail_screen.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/utils/url_utils.dart';
import 'package:pchaa_flutter/widgets/menu_card.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<AvailableMenuItem>? _menuItems;
  bool _isLoading = true;
  String? _errorMessage;
  int _cartItemCount = 0;
  List<AvailableMenuItem>? _filteredItems;
  @override
  void initState() {
    super.initState();
    _loadMenuItems();
    _loadCart();
  }

  Future<void> _loadCart() async {
    await cartService.refresh();
    setState(() {
      _cartItemCount = cartService.items.length;
    });
  }

  Future<void> _loadMenuItems() async {
    try {
      if (!mounted) return;
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final menuItems = await client.menuItem.getAllAvailableMenuItems();

      if (!mounted) return;
      setState(() {
        _menuItems = menuItems;
        _filteredItems = menuItems;
        debugPrint(_menuItems.toString());
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterItems(String filter) {
    setState(() {
      _filteredItems = _menuItems!
          .where(
            (item) => item.name.toLowerCase().contains(filter.toLowerCase()),
          )
          .toList();
    });
  }

  bool isLoggedIn = googleAuthService.isLoggedIn;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 96,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  // Background food image (hidden if logged in)
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/food.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Gradient / overlay container
                  Container(
                    height: 300,
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
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),

                  // Positioned welcome text and button
                  Positioned(
                    bottom: 10,
                    left: 30,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "MENU",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2, 1),
                                      blurRadius: 10,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_menuItems == null || _menuItems!.isEmpty)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.restaurant_menu, size: 48, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No menu items found'),
                    ],
                  ),
                ),

              Container(
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 44,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(87, 104, 159, 180),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          _filterItems(value);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 👈 2 columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    // Make tiles taller to avoid content overflow
                    childAspectRatio: 0.95,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredItems?.length ?? 0,
                  itemBuilder: (context, index) {
                    return MenuCard(
                      imagePath: UrlUtils.getDisplayableImageUrl(
                        _filteredItems![index].imageUrl,
                      ),
                      name: _filteredItems![index].name,
                      price: _filteredItems![index].basePrice,
                      isDisabled: !_filteredItems![index].forSale,
                      onAdd: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuDetailScreen(
                              menuId: _filteredItems![index].id!,
                            ),
                          ),
                        );
                        setState(() {
                          _loadCart();
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (isLoggedIn && isShopOpen)
                  ? () async {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     content: Text(
                      //       'Add to cart functionality coming soon!',
                      //     ),
                      //   ),
                      // );
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartList(),
                        ),
                      );
                      setState(() {
                        _loadCart();
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B8FA3),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: (isLoggedIn && isShopOpen)
                    ? Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (_cartItemCount != 0)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    _cartItemCount.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5B8FA3),
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "ออร์เดอร์ของฉัน",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "฿0",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        (isShopOpen ? "ต้อง Login ก่อน" : "ร้านยังไม่เปิด"),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
