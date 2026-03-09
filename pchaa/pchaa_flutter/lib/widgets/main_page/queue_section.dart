import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/widgets/queue/myqueue.dart';
import 'package:pchaa_flutter/widgets/queue/queueready.dart';

class QueueSection extends StatefulWidget {
  final bool isOpen;
  final bool isLoggedIn;
  final List<Order> orders;
  final VoidCallback? onNavigate;
  const QueueSection({
    super.key,
    required this.orders,
    required this.isOpen,
    required this.isLoggedIn,
    this.onNavigate
  });

  @override
  State<QueueSection> createState() => _QueueSectionState();
}

class _QueueSectionState extends State<QueueSection> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isOpen) {
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

    if (!widget.isLoggedIn) {
      return Queueready();
    }

    return Myqueue(
      onNavigate: widget.onNavigate,
      limit: 3,
      queueList: widget.orders,
    );
  }
}
