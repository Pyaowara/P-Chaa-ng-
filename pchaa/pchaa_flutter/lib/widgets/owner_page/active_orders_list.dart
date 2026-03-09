import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/widgets/order_manage/index.dart'; // For OrderCard
import 'package:pchaa_flutter/screens/order_management.dart';

class ActiveOrdersList extends StatelessWidget {
  final bool isLoading;
  final List<Order> todayOrders;
  final String? Function(int) getUserNameForOrder;
  final VoidCallback onOrderManaged;

  const ActiveOrdersList({
    super.key,
    required this.isLoading,
    required this.todayOrders,
    required this.getUserNameForOrder,
    required this.onOrderManaged,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && todayOrders.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      );
    }

    final activeOrders = todayOrders
        .where((order) => order.status == OrderStatus.ordered)
        .toList();

    if (activeOrders.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(Icons.inbox, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            const Text(
              'ไม่มีออเดอร์ใหม่',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: activeOrders.length,
      itemBuilder: (context, index) {
        final order = activeOrders[index];
        return OrderCard(
          order: order,
          userName: getUserNameForOrder(order.id!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderManagementPage(
                  orderId: order.id!,
                  order: order,
                  userName: getUserNameForOrder(order.id!),
                ),
              ),
            ).then((_) {
              onOrderManaged();
            });
          },
        );
      },
    );
  }
}
