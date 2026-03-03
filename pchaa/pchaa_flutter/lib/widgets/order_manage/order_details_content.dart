import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'order_info_card.dart';
import 'order_items_list.dart';

/// Widget for displaying order details content (info card + items list)
class OrderDetailsContent extends StatelessWidget {
  final Order order;
  final List<OrderItem> items;
  final String? userName;

  const OrderDetailsContent({
    super.key,
    required this.order,
    required this.items,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order info card
          OrderInfoCard(
            order: order,
            userName: userName,
          ),
          const SizedBox(height: 24),

          // Order items section
          OrderItemsList(items: items),
        ],
      ),
    );
  }
}
