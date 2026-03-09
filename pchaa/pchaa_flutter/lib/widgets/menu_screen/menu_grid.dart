import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/utils/url_utils.dart';
import 'package:pchaa_flutter/widgets/menu_screen/menu_card.dart';

class MenuGrid extends StatelessWidget {
  final List<AvailableMenuItem>? filteredItems;
  final bool isShopOpen;
  final void Function(AvailableMenuItem) onAdd;

  const MenuGrid({
    super.key,
    required this.filteredItems,
    required this.isShopOpen,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double spacing = 10.0;
          final double itemWidth = (constraints.maxWidth - spacing) / 2;

          return Wrap(
            spacing: spacing,
            runSpacing: 10.0,
            children: (filteredItems ?? []).map((item) {
              return SizedBox(
                width: itemWidth,
                child: MenuCard(
                  imagePath: UrlUtils.getDisplayableImageUrl(item.imageUrl),
                  name: item.name,
                  price: item.basePrice,
                  isDisabled: !item.forSale || !isShopOpen,
                  onAdd: () => onAdd(item),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
