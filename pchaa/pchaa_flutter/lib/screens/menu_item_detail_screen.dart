import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/widgets/menu_items/menu_item_detail_content.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menuItem.name),
      ),
      body: MenuItemDetailContent(
        menuItem: widget.menuItem,
        selectedOptions: _selectedOptions,
        totalPrice: _calculateTotalPrice(),
        onAddToCart: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Add to cart functionality coming soon!',
              ),
            ),
          );
        },
        onChoiceSelected: (group, choice) {
          setState(() {
            final isSelected = _selectedOptions[group.title] == choice;
            _selectedOptions[group.title] = isSelected ? null : choice;
          });
        },
      ),
    );
  }
}
