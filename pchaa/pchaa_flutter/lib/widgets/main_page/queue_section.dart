import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/widgets/myqueue.dart';
import 'package:pchaa_flutter/widgets/queueready.dart';

class QueueSection extends StatelessWidget {
  final bool isOpen;
  final bool isLoggedIn;

  const QueueSection({
    super.key,
    required this.isOpen,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOpen) {
      return Expanded(
        child: Center(
          child: Text(
            'Queue Not\nAvailable',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      );
    }

    return isLoggedIn
        ? Myqueue(
            limit: 3,
            queueList: [
              Order(
                userId: 1,
                status: OrderStatus.preparing,
                type: OrderType.I,
                totalOrderPrice: 30,
                orderDate: DateTime.now(),
                queueNumber: "I001",
              ),
              Order(
                userId: 1,
                status: OrderStatus.preparing,
                type: OrderType.I,
                totalOrderPrice: 30,
                orderDate: DateTime.now(),
                queueNumber: "I001",
              ),
              Order(
                userId: 1,
                status: OrderStatus.preparing,
                type: OrderType.I,
                totalOrderPrice: 30,
                orderDate: DateTime.now(),
                queueNumber: "I001",
              ),
              Order(
                userId: 1,
                status: OrderStatus.preparing,
                type: OrderType.I,
                totalOrderPrice: 30,
                orderDate: DateTime.now(),
                queueNumber: "I001",
              ),
            ],
          )
        : Queueready();
  }
}
