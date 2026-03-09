import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/screens/cart_list.dart';
import 'package:pchaa_flutter/screens/menu_detail_screen.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/widgets/menu_screen/menu_grid.dart';
import 'package:pchaa_flutter/widgets/menu_screen/menu_screen_bottom_bar.dart';
import 'package:pchaa_flutter/widgets/menu_screen/menu_screen_header.dart';
import 'package:pchaa_flutter/widgets/menu_screen/menu_search_bar.dart';

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
  double _cartTotalPrice = 0;
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
      _cartTotalPrice = cartService.items.fold(
        0,
        (previousValue, element) => previousValue + element.cart.totalPrice,
      );
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
              MenuScreenHeader(
                onBack: () {
                  Navigator.pop(context);
                },
              ),
              if (_isLoading)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_errorMessage != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 48, color: Colors.red),
                        SizedBox(height: 16),
                        Text(
                          'Error loading menu',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadMenuItems,
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              else if (_menuItems == null || _menuItems!.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.restaurant_menu, size: 48, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No menu items found'),
                      ],
                    ),
                  ),
                ),

              if (!_isLoading && _errorMessage == null)
                MenuSearchBar(
                  controller: searchController,
                  onChanged: _filterItems,
                ),
              if (!_isLoading && _errorMessage == null)
                MenuGrid(
                  filteredItems: _filteredItems,
                  isShopOpen: isShopOpen,
                  onAdd: (item) async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuDetailScreen(
                          menuId: item.id!,
                        ),
                      ),
                    );
                    setState(() {
                      _loadCart();
                    });
                  },
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MenuScreenBottomBar(
        isLoggedIn: isLoggedIn,
        isShopOpen: isShopOpen,
        cartItemCount: _cartItemCount,
        cartTotalPrice: _cartTotalPrice,
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartList(),
            ),
          );
          setState(() {
            _loadCart();
          });
        },
      ),
    );
  }
}
