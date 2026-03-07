import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/widgets/order_manage/order_constants.dart';
import 'package:pchaa_flutter/widgets/order_manage/order_status_chip.dart';

/// Widget for displaying order information card
class OrderInfoCard extends StatelessWidget {
  final Order order;
  final String? userName;

  const OrderInfoCard({
    super.key,
    required this.order,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'สถานะ:',
                  style: AppTextStyles.buttonLabel,
                ),
                OrderStatusChip(status: order.status),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ประเภท:',
                  style: AppTextStyles.buttonLabel,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      OrderConstants.formatOrderType(order.type),
                      style: const TextStyle(fontSize: 14),
                    ),
                    if (order.type == OrderType.S &&
                        order.pickupTime != null)
                      Text(
                        'รับ: ${order.pickupTime!.hour.toString().padLeft(2, '0')}:${order.pickupTime!.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ราคารวม:',
                  style: AppTextStyles.buttonLabel,
                ),
                Text(
                  '฿${order.totalOrderPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (order.queueNumber != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'หมายเลขคิว:',
                    style: AppTextStyles.buttonLabel,
                  ),
                  Text(
                    order.queueNumber ?? 'N/A',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            if (order.queueNumber != null) const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ผู้ส่ง:',
                  style: AppTextStyles.buttonLabel,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (userName != null)
                      Text(
                        userName!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
