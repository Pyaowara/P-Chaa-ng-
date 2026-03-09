import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';

class OrderStatusBottomBar extends StatelessWidget {
  final Order orderDetail;
  final int? queueLength;
  final int? estimatedPrepTime;
  final VoidCallback onCancelOrder;

  const OrderStatusBottomBar({
    super.key,
    required this.orderDetail,
    required this.queueLength,
    required this.estimatedPrepTime,
    required this.onCancelOrder,
  });

  @override
  Widget build(BuildContext context) {
    if (orderDetail.status == OrderStatus.cancelled) {
      return const SizedBox.shrink();
    }

    final hasQueueOrPrepInfo = queueLength != null || estimatedPrepTime != null;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      height: 150,
      decoration: const BoxDecoration(
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
                crossAxisAlignment: hasQueueOrPrepInfo
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ราคารวม",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '฿${orderDetail.totalOrderPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  orderDetail.status != OrderStatus.received &&
                      orderDetail.status != OrderStatus.cancelled &&
                      orderDetail.status != OrderStatus.finished
                  ? onCancelOrder
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
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
