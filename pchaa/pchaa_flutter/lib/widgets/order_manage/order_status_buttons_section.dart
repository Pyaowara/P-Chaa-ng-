import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'order_constants.dart';

/// Widget for displaying order status change buttons at the bottom
class OrderStatusButtonsSection extends StatelessWidget {
  final List<OrderStatus> availableStatuses;
  final bool isUpdating;
  final Function(OrderStatus) onStatusSelected;

  const OrderStatusButtonsSection({
    super.key,
    required this.availableStatuses,
    required this.isUpdating,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (availableStatuses.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          ...availableStatuses.map((status) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OrderConstants.getStatusColor(status),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                    ),
                  ),
                  onPressed: isUpdating
                      ? null
                      : () {
                          onStatusSelected(status);
                        },
                  child: isUpdating
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          OrderConstants.formatOrderStatus(status),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
