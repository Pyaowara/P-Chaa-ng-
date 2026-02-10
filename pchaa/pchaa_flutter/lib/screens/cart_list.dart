import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/widgets/cart/cart_bottom_bar.dart';
import 'package:pchaa_flutter/widgets/cart/cart_empty_state.dart';
import 'package:pchaa_flutter/widgets/cart/cart_item_card.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<Cart> _cartItems = [];
  Map<int, MenuItemWithUrl?> _menuItemsCache = {};
  double _totalPrice = 0.0;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await cartService.refresh();
      final items = cartService.items;

      // Fetch menu item details for each cart item
      final Map<int, MenuItemWithUrl?> menuCache = {};
      for (final cartItem in items) {
        if (!menuCache.containsKey(cartItem.menuItemId)) {
          try {
            final menuItem = await client.menuItem.getMenuItemById(
              cartItem.menuItemId,
            );
            menuCache[cartItem.menuItemId] = menuItem;
          } catch (e) {
            menuCache[cartItem.menuItemId] = null;
          }
        }
      }

      if (!mounted) return;
      setState(() {
        _cartItems = items;
        _menuItemsCache = menuCache;
        _totalPrice = items.fold(0.0, (sum, item) => sum + item.totalPrice);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _removeCartItem(int cartId) async {
    try {
      await client.cart.deleteCart(cartId);
      await _loadCart();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ลบรายการแล้ว')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _clearCart() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ล้างตะกร้า'),
        content: const Text('คุณต้องการลบรายการทั้งหมดใช่หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('ลบทั้งหมด'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await client.cart.clearMyCart();
        await _loadCart();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ล้างตะกร้าแล้ว')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      }
    }
  }

  void _onCheckout() {
    // TODO: Implement checkout
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Checkout coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตะกร้าสินค้า'),
        actions: [
          if (_cartItems.isNotEmpty)
            IconButton(
              onPressed: _clearCart,
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'ล้างตะกร้า',
            ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: _cartItems.isNotEmpty
          ? CartBottomBar(
              totalPrice: _totalPrice,
              onCheckout: _onCheckout,
            )
          : null,
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadCart,
              child: const Text('ลองใหม่'),
            ),
          ],
        ),
      );
    }

    if (_cartItems.isEmpty) {
      return const CartEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _loadCart,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 100),
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = _cartItems[index];
          return CartItemCard(
            cartItem: cartItem,
            menuItem: _menuItemsCache[cartItem.menuItemId],
            onDismissed: () => _removeCartItem(cartItem.id!),
          );
        },
      ),
    );
  }
}
