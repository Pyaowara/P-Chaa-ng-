import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/widgets/cart/cart_empty_state.dart';
import 'package:pchaa_flutter/widgets/cart/cart_item_card.dart';

class CartListBody extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final List<CartDetail> cartItems;
  final Future<void> Function() onRefresh;
  final void Function(int) onRemoveItem;

  const CartListBody({
    super.key,
    required this.isLoading,
    this.error,
    required this.cartItems,
    required this.onRefresh,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRefresh,
              child: const Text('ลองใหม่'),
            ),
          ],
        ),
      );
    }

    if (cartItems.isEmpty) {
      return const CartEmptyState();
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 100),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartDetail = cartItems[index];
          return CartItemCard(
            cartItem: cartDetail.cart,
            menuItemName: cartDetail.menuItemName,
            rawimageUrl: cartDetail.imageUrl,
            onDismissed: () => onRemoveItem(cartDetail.cart.id!),
          );
        },
      ),
    );
  }
}
