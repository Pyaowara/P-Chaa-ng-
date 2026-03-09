import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/screens/customer_order_status.dart';
import 'package:pchaa_flutter/screens/all_queue_page.dart';

class Myqueue extends StatefulWidget {
  // limit for showing how much QueueListTile should display -1 for no limit
  final int limit;
  final List<Order> queueList;
  final VoidCallback? onNavigate;
  const Myqueue({super.key, this.limit = -1, required this.queueList,this.onNavigate});

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

    if (items.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "My Queue",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "คุณยังไม่ได้สั่งออเดอร์",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Text(
                "You didn't order anything",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "My Queue",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              // Build tiles from `queueList`
              children: [
                ...List.generate(maxItems, (index) {
                  final Order queueitem = items[index];
                  return QueueListTile(
                    onNavigate: widget.onNavigate,
                    order: queueitem,
                    // description: "SD",
                  );
                }),
                if (items.length > maxItems)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllQueuePage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "See All>>>",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QueueListTile extends StatelessWidget {
  final Order order;
  final String description;
  final VoidCallback? onNavigate;
  const QueueListTile({
    super.key,
    required this.order,
    this.description = "",
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerOrderStatus(
              orderid: order.id!,
            ),
          ),
        ).then((_) {
          onNavigate?.call();
        });
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Color(0xFF5A9CB5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: Image.asset("assets/images/chefhat.png"),
          title: Text(
            switch (order.status) {
              OrderStatus.ordered => "ส่งออร์เดอร์แล้ว",
              OrderStatus.preparing => "กำลังทำ",
              OrderStatus.confirmed => "ร้านรับออเดอร์แล้ว",
              OrderStatus.cancelled => "ออเดอร์ถูกยกเลิก",
              OrderStatus.finished => "พร้อมเสริฟ",
              OrderStatus.received => "รับอาหารแล้ว",
            },
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (description != ""
                  ? Text(
                      description,
                      style: TextStyle(color: Colors.black),
                    )
                  : SizedBox()),
              Text(
                switch (order.type) {
                  OrderType.I => "Immediate",
                  OrderType.S => "Scheduled",
                },
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          trailing: Text(
            order.queueNumber ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
