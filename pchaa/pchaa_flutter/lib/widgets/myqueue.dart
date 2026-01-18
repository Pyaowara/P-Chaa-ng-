import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';

class Myqueue extends StatefulWidget {
  // limit for showing how much QueueListTile should display -1 for no limit
  final int limit;
  final List<Order> queueList;
  const Myqueue({super.key, this.limit = -1,required this.queueList});

  @override
  State<Myqueue> createState() => MyqueueState();
}

class MyqueueState extends State<Myqueue> {
  @override
  Widget build(BuildContext context) {
    // Access props via `widget` in State and respect the limit
    final items = widget.queueList;
    final int maxItems = widget.limit != -1
        ? widget.limit.clamp(0, items.length)
        : items.length;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Queue",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Center(
            child: Column(
              // Build tiles from `queueList`
              children: List.generate(maxItems, (index) {
                final Order queueitem = items[index];
                return QueueListTile(
                  orderstatus: switch (queueitem.status) {
                    OrderStatus.ordered => "ส่งออร์เดอร์แล้ว",
                    OrderStatus.preparing => "กำลังทำ",
                    OrderStatus.confirmed => "ร้านรับออร์เดอร์แล้ว",
                    OrderStatus.cancelled => "ออร์เดอร์ถูกยกเลิก",
                    OrderStatus.finished => "พร้อมเสริฟ",
                    OrderStatus.received => "รับอาหารแล้ว"
                  },
                  orderNumber: queueitem.queueNumber ?? "0000",
                  description: "SD",
                  ordertype: switch (queueitem.type) {
                    OrderType.I => "Immediate",
                    OrderType.S => "Scheduled",
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class QueueListTile extends StatelessWidget {
  final String orderstatus;
  final String description;
  final String ordertype;
  final String orderNumber;
  const QueueListTile({super.key, required this.orderstatus, required this.description, required this.ordertype,required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFF5A9CB5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Image.asset("assets/images/chefhat.png"),
        title: Text(
          orderstatus,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              ordertype,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        trailing: Text(
          orderNumber,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
