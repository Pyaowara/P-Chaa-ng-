import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/widgets/cart/cart_bottom_bar.dart';
import 'package:pchaa_flutter/widgets/cart/cart_list_body.dart';
import 'package:pchaa_flutter/widgets/cart/checkout_modal.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<CartDetail> _cartItems = [];
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

      if (!mounted) return;
      setState(() {
        _cartItems = items;
        _totalPrice = items.fold(
          0.0,
          (sum, item) => sum + item.cart.totalPrice,
        );
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
      await cartService.remove(cartId);
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
        await cartService.clear();
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
    showDialog(
      context: context,
      builder: (context) => const CheckoutModal(),
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
      body: CartListBody(
        isLoading: _isLoading,
        error: _error,
        cartItems: _cartItems,
        onRefresh: _loadCart,
        onRemoveItem: _removeCartItem,
      ),
      bottomNavigationBar: _cartItems.isNotEmpty
          ? CartBottomBar(
              totalPrice: _totalPrice,
              onCheckout: _onCheckout,
            )
          : null,
    );
  }
}
