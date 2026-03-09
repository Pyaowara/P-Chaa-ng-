import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import '../services/app_services.dart';
import '../widgets/menu_items/available_menu_item_card.dart';
import 'menu_item_detail_screen.dart';

class AvailableMenuItemsScreen extends StatefulWidget {
  const AvailableMenuItemsScreen({super.key});

  @override
  State<AvailableMenuItemsScreen> createState() =>
      _AvailableMenuItemsScreenState();
}

class _AvailableMenuItemsScreenState extends State<AvailableMenuItemsScreen> {
  List<AvailableMenuItem>? _menuItems;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Menu Items'),
        actions: [
          IconButton(
            onPressed: _loadMenuItems,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading menu items...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $_errorMessage', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadMenuItems,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_menuItems == null || _menuItems!.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text('No menu items found'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMenuItems,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _menuItems!.length,
        itemBuilder: (context, index) {
          final menuItem = _menuItems![index];
          return AvailableMenuItemCard(
            menuItem: menuItem,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuItemDetailScreen(menuItem: menuItem),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
