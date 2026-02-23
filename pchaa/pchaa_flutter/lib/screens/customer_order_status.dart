import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/widgets/order_status/order_status_icon.dart';
import 'package:pchaa_flutter/widgets/order_status/order_status_stepper.dart';

class CustomerOrderStatus extends StatefulWidget {
  final Order orderdetail;
  const CustomerOrderStatus({super.key, required this.orderdetail});

  @override
  State<CustomerOrderStatus> createState() => _CustomerOrderStatusState();
}

class _CustomerOrderStatusState extends State<CustomerOrderStatus> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.orderdetail.id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "รายการออเดอร์",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "เลขออเดอร์ ${widget.orderdetail.queueNumber ?? widget.orderdetail.id}",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          (widget.orderdetail.status == OrderStatus.received ||
                  widget.orderdetail.status == OrderStatus.cancelled
              ? OrderStatusIcon()
              : OrderStatusStepper(currentStep: 1)),
        ],
      ),
    );
  }
}
