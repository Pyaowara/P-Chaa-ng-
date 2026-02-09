import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/utils/url_utils.dart';

/// A card widget displaying a single cart item with its details.
class CartItemCard extends StatelessWidget {
  final Cart cartItem;
  final MenuItemWithUrl? menuItem;
  final VoidCallback onDismissed;

  const CartItemCard({
    super.key,
    required this.cartItem,
    this.menuItem,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = UrlUtils.getDisplayableImageUrl(menuItem?.imageUrl);

    return Dismissible(
      key: Key('cart_${cartItem.id}'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        onDismissed();
        return false; // We handle removal manually
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(imageUrl),
              const SizedBox(width: 12),
              Expanded(child: _buildDetails()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
            )
          : _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 70,
      height: 70,
      color: Colors.grey[300],
      child: Icon(Icons.restaurant, color: Colors.grey[500]),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Menu name
        Text(
          menuItem?.name ?? 'Menu Item #${cartItem.menuItemId}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),

        // Selected options
        if (cartItem.selectedOptions.isNotEmpty)
          Wrap(
            spacing: 4,
            runSpacing: 2,
            children: cartItem.selectedOptions.map((option) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  option.name,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.blue,
                  ),
                ),
              );
            }).toList(),
          ),

        // Additional message
        if (cartItem.additionalMessage != null &&
            cartItem.additionalMessage!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '📝 ${cartItem.additionalMessage}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

        const SizedBox(height: 8),

        // Price and quantity row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'x${cartItem.quantity}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            Text(
              '฿${cartItem.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
