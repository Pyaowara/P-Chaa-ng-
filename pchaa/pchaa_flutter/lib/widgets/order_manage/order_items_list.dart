import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'order_item_card.dart';

/// Widget for displaying order items list
class OrderItemsList extends StatelessWidget {
  final List<OrderItem> items;
  final bool isLoading;

  const OrderItemsList({
    super.key,
    required this.items,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'รายการสั่ง',
          style: AppTextStyles.sectionTitle,
        ),
        const SizedBox(height: 12),
        if (items.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text('ไม่มีรายการสั่งซื้อ'),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return OrderItemCard(item: item);
            },
          ),
      ],
    );
  }
}
