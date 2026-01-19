import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';

class MenuItemDetailScreen extends StatefulWidget {
  final AvailableMenuItem menuItem;

  const MenuItemDetailScreen({super.key, required this.menuItem});

  @override
  State<MenuItemDetailScreen> createState() => _MenuItemDetailScreenState();
}

class _MenuItemDetailScreenState extends State<MenuItemDetailScreen> {
  // Store selected options for each customization group
  final Map<String, AvailableAddOnOption?> _selectedOptions = {};

  @override
  void initState() {
    super.initState();
    // Initialize selected options
    for (final group in widget.menuItem.customization) {
      _selectedOptions[group.title] = null;
    }
  }

  double _calculateTotalPrice() {
    double total = widget.menuItem.basePrice;
    for (final selectedOption in _selectedOptions.values) {
      if (selectedOption != null) {
        total += selectedOption.price;
      }
    }
    return total;
  }

  String _getDisplayableImageUrl(String? imageUrl) {
    if (imageUrl == null) return '';
    return imageUrl.replaceAll('localhost', '10.0.2.2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menuItem.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (widget.menuItem.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    _getDisplayableImageUrl(widget.menuItem.imageUrl),
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
                  '${widget.menuItem.basePrice.toStringAsFixed(2)}',
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
                  '${widget.menuItem.timeToPrepare} min',
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
                color: widget.menuItem.forSale
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.menuItem.forSale ? Colors.green : Colors.red,
                ),
              ),
              child: Text(
                widget.menuItem.forSale
                    ? 'Available for Sale'
                    : 'Not Available',
                style: TextStyle(
                  color: widget.menuItem.forSale
                      ? Colors.green[700]
                      : Colors.red[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Ingredients
            if (widget.menuItem.ingredientIds != null &&
                widget.menuItem.ingredientIds!.isNotEmpty)
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
                    children: widget.menuItem.ingredientIds!.map((id) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
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
            if (widget.menuItem.customization.isNotEmpty)
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
                  ...widget.menuItem.customization.map((group) {
                    return _buildCustomizationGroup(group);
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
                    '\$${_calculateTotalPrice().toStringAsFixed(2)}',
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
                onPressed: widget.menuItem.forSale
                    ? () {
                        // TODO: Implement add to cart functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Add to cart functionality coming soon!',
                            ),
                          ),
                        );
                      }
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
      ),
    );
  }

  Widget _buildCustomizationGroup(AvailableCustomizationGroup group) {
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
    final isSelected = _selectedOptions[group.title] == choice;

    return InkWell(
      onTap: choice.forSale
          ? () {
              setState(() {
                if (group.pickOne) {
                  // Single selection
                  _selectedOptions[group.title] = isSelected ? null : choice;
                } else {
                  // Multiple selection (for future use)
                  // For now, treat as single since UI doesn't support multiple
                  _selectedOptions[group.title] = isSelected ? null : choice;
                }
              });
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.withOpacity(0.1)
              : choice.forSale
              ? Colors.white
              : Colors.grey.withOpacity(0.1),
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
                    Text(
                      'Not available',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.blue,
              )
            else if (choice.forSale)
              Icon(
                Icons.radio_button_unchecked,
                color: Colors.grey,
              )
            else
              Icon(
                Icons.cancel,
                color: Colors.red,
              ),
          ],
        ),
      ),
    );
  }
}
