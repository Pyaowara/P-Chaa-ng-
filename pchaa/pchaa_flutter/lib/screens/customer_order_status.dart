import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/widgets/cart/cart_item_card.dart';
import 'package:pchaa_flutter/widgets/order_manage/index.dart';
import 'package:pchaa_flutter/widgets/order_status/order_status_icon.dart';
import 'package:pchaa_flutter/widgets/order_status/order_status_stepper.dart';

class CustomerOrderStatus extends StatefulWidget {
  final Order orderdetail;
  const CustomerOrderStatus({super.key, required this.orderdetail});

  @override
  State<CustomerOrderStatus> createState() => _CustomerOrderStatusState();
}

class _CustomerOrderStatusState extends State<CustomerOrderStatus> {
  Order? _orderdetail;
  List<OrderItem> _orderItemList = [];
  bool _isLoadingOrderItems = true;
  String? _orderItemsError;

  Future<void> _fetchOrderItems() async {
    setState(() {
      _isLoadingOrderItems = true;
      _orderItemsError = null;
    });

    try {
      final orderitems = await client.order.getOrderItems(
        widget.orderdetail.id!,
      );
      if (mounted) {
        setState(() {
          _orderItemList = orderitems;
          _isLoadingOrderItems = false;
        });
      }
    } catch (e) {
      debugPrint('Failed to fetch order items: $e');
      if (mounted) {
        setState(() {
          _orderItemsError = 'ไม่สามารถโหลดรายการอาหารได้';
          _isLoadingOrderItems = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _orderdetail = widget.orderdetail;
    _fetchOrderItems();
  }

  void onCancelOrder() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันการยกเลิกออเดอร์'),
          content: Text('คุณแน่ใจหรือว่าต้องการยกเลิกออเดอร์นี้?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('ไม่'),
            ),
            TextButton(
              onPressed: () async{
                Navigator.of(context).pop();
                Order neworderdetail = await client.order.cancelMyOrder(_orderdetail!.id!);
                setState(() {
                  _orderdetail = neworderdetail;
                });
              },
              child: Text('ใช่'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(_orderdetail!.id.toString());
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
              "เลขออเดอร์ ${_orderdetail!.queueNumber ?? _orderdetail!.id}",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (_orderdetail!.status == OrderStatus.ordered ||
                    _orderdetail!.status == OrderStatus.cancelled
                ? OrderStatusIcon(
                    orderStatus: _orderdetail!.status,
                  )
                : OrderStatusStepper(orderStatus: _orderdetail!.status)),
            SizedBox(
              height: 20,
            ),
            Text(
              "ออเดอร์ของฉัน",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: _isLoadingOrderItems
                    ? const Center(child: CircularProgressIndicator())
                    : _orderItemsError != null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_orderItemsError!),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: _fetchOrderItems,
                              child: const Text('ลองใหม่'),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: List.generate(_orderItemList.length, (
                            rowIndex,
                          ) {
                            return OrderItemCard(item: _orderItemList[rowIndex]);
                          }),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _orderdetail!.status != OrderStatus.cancelled
          ? Container(
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
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("จำนวนคิวก่อนหน้า x คิว"),
                          Text(
                            "ราคารวม",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("เวลาประมาณ xx นาที"),
                          Text(
                            '฿${_orderdetail?.totalOrderPrice}',
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
                      onPressed: onCancelOrder,
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
            )
          : null,
    );
  }
}
