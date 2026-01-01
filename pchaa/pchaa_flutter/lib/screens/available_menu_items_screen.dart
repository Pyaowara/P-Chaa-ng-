import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import '../main.dart';
import 'menu_item_detail_screen.dart';

class AvailableMenuItemsScreen extends StatefulWidget {
  const AvailableMenuItemsScreen({super.key});

  @override
  State<AvailableMenuItemsScreen> createState() => _AvailableMenuItemsScreenState();
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
          return _buildMenuItemCard(_menuItems![index]);
        },
      ),
    );
  }

  String _getDisplayableImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return '';
    return imageUrl.replaceAll('localhost', '10.0.2.2');
  }

  Widget _buildMenuItemCard(AvailableMenuItem menuItem) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MenuItemDetailScreen(menuItem: menuItem),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with local greyscale logic
            if (menuItem.imageUrl != null && menuItem.imageUrl!.isNotEmpty)
              ColorFiltered(
                // Only greyscale the image if not for sale
                colorFilter: menuItem.forSale
                    ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                    : const ColorFilter.matrix(<double>[
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0,      0,      0,      1, 0,
                      ]),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    _getDisplayableImageUrl(menuItem.imageUrl),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                    ),
                  ),
                ),
              ),

            // Content section (Always in color)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          menuItem.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildStatusBadge(menuItem.forSale),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        // Removed the $ sign here
                        menuItem.basePrice.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.timer_outlined, size: 18, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text('${menuItem.timeToPrepare} min'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool forSale) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: forSale ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: forSale ? Colors.green : Colors.red),
      ),
      child: Text(
        forSale ? 'AVAILABLE' : 'UNAVAILABLE',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: forSale ? Colors.green[700] : Colors.red[700],
        ),
      ),
    );
  }
}