import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
class OrderStatusIcon extends StatefulWidget {
  final OrderStatus orderStatus;
  const OrderStatusIcon({
    super.key,
    this.orderStatus = OrderStatus.ordered
  });

  @override
  State<OrderStatusIcon> createState() => _OrderStatusIconState();
}

class _OrderStatusIconState extends State<OrderStatusIcon>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // rotate while pending
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.orderStatus == OrderStatus.ordered
                  ? Color(0xFFFACE68)
                  : Colors.red,
              shape: BoxShape.circle,
            ),
            child: widget.orderStatus == OrderStatus.ordered
                ? RotationTransition(
                    turns: _controller,
                    child: Icon(
                      Icons.hourglass_empty,
                      size: 100,
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    Icons.close,
                    size: 100,
                    color: Colors.white,
                  ),
          ),
          Text(
            widget.orderStatus == OrderStatus.ordered
                ? "รอรับออเดอร์"
                : "ออเดอร์ถูกยกเลิก",
                style: TextStyle(fontWeight: FontWeight.bold,color: widget.orderStatus == OrderStatus.ordered
                  ? Color.fromARGB(255, 196, 153, 54)
                  : Colors.red,fontSize: 18),
          ),
        ],
      ),
    );
  }
}
