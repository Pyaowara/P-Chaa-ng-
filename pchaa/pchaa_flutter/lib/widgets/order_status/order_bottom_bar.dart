import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';

class OrderBottomBar extends StatelessWidget {
  final Order order;
  final int? queueLength;
  final int? estimatedPrepTime;
  final VoidCallback onCancelOrder;

  const OrderBottomBar({
    super.key,
    required this.order,
    this.queueLength,
    this.estimatedPrepTime,
    required this.onCancelOrder,
  });

  @override
  Widget build(BuildContext context) {
    if (order.status == OrderStatus.cancelled) {
      return const SizedBox.shrink();
    }

    final hasQueueOrPrepInfo = queueLength != null || estimatedPrepTime != null;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xFFececec),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: hasQueueOrPrepInfo
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              if (hasQueueOrPrepInfo)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (queueLength != null)
                      Text("จำนวนคิวก่อนหน้า $queueLength คิว"),
                    if (estimatedPrepTime != null)
                      Text("เวลาประมาณ $estimatedPrepTime นาที"),
                  ],
                ),
              Column(
                crossAxisAlignment: hasQueueOrPrepInfo ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    "ราคารวม",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '฿${order.totalOrderPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: order.status != OrderStatus.received
                  ? onCancelOrder
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
              child: Text(
                "ยกเลิกออเดอร์",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
