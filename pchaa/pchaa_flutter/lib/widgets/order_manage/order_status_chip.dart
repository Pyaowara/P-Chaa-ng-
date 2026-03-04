import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/widgets/order_manage/order_constants.dart';

/// Widget for displaying order status as a chip/badge
class OrderStatusChip extends StatelessWidget {
  final OrderStatus status;
  final double? borderRadius;

  const OrderStatusChip({
    super.key,
    required this.status,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final color = OrderConstants.getStatusColor(status);
    final label = OrderConstants.formatOrderStatus(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.small),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
