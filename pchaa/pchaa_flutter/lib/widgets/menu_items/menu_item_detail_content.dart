import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/utils/url_utils.dart';

class MenuItemDetailContent extends StatelessWidget {
  final AvailableMenuItem menuItem;
  final Map<String, AvailableAddOnOption?> selectedOptions;
  final VoidCallback onAddToCart;
  final double totalPrice;
  final void Function(AvailableCustomizationGroup, AvailableAddOnOption) onChoiceSelected;

  const MenuItemDetailContent({
    super.key,
    required this.menuItem,
    required this.selectedOptions,
    required this.onAddToCart,
    required this.totalPrice,
    required this.onChoiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          if (menuItem.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  UrlUtils.getDisplayableImageUrl(menuItem.imageUrl),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text('Failed to load image'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

          const SizedBox(height: 16),

          // Basic info
          Row(
            children: [
              Icon(
                Icons.attach_money,
                size: 24,
                color: Colors.green[600],
              ),
              Text(
                menuItem.basePrice.toStringAsFixed(2),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.green[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 24),
              Icon(
                Icons.timer,
                size: 20,
                color: Colors.orange[600],
              ),
              const SizedBox(width: 4),
              Text(
                '${menuItem.timeToPrepare} min',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.orange[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // For Sale status
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: menuItem.forSale
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: menuItem.forSale ? Colors.green : Colors.red,
              ),
            ),
            child: Text(
              menuItem.forSale
                  ? 'Available for Sale'
                  : 'Not Available',
              style: TextStyle(
                color: menuItem.forSale
                    ? Colors.green[700]
                    : Colors.red[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Ingredients
          if (menuItem.ingredientIds != null &&
              menuItem.ingredientIds!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ingredients:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: menuItem.ingredientIds!.map((id) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Ingredient ID: $id',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

          const SizedBox(height: 16),

          // Customizations
          if (menuItem.customization.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customization Options:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...menuItem.customization.map((group) {
                  return _buildCustomizationGroup(context, group);
                }),
              ],
            ),

          const SizedBox(height: 24),

          // Total price
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Add to cart button (placeholder)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: menuItem.forSale
                  ? onAddToCart
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizationGroup(BuildContext context, AvailableCustomizationGroup group) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              group.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              group.pickOne ? 'Choose one option:' : 'Choose multiple options:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            ...group.choices.map((choice) {
              return _buildChoiceOption(group, choice);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceOption(
    AvailableCustomizationGroup group,
    AvailableAddOnOption choice,
  ) {
    final isSelected = selectedOptions[group.title] == choice;

    return InkWell(
      onTap: choice.forSale ? () => onChoiceSelected(group, choice) : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.withValues(alpha: 0.1)
              : choice.forSale
              ? Colors.white
              : Colors.grey.withValues(alpha: 0.1),
          border: Border.all(
            color: isSelected
                ? Colors.blue
                : choice.forSale
                ? Colors.grey[300]!
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    choice.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: choice.forSale ? Colors.black : Colors.grey,
                    ),
                  ),
                  if (choice.price > 0)
                    Text(
                      '+\$${choice.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: choice.forSale ? Colors.green[600] : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  if (!choice.forSale)
                    const Text(
                      'Not available',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.blue,
              )
            else if (choice.forSale)
              const Icon(
                Icons.radio_button_unchecked,
                color: Colors.grey,
              )
            else
              const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
          ],
        ),
      ),
    );
  }
}
