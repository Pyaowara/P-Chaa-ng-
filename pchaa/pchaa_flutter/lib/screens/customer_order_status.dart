import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/widgets/order_manage/index.dart';
import 'package:pchaa_flutter/widgets/order_status/order_status_icon.dart';
import 'package:pchaa_flutter/widgets/order_status/order_status_stepper.dart';

class CustomerOrderStatus extends StatefulWidget {
  final int orderid;
  const CustomerOrderStatus({super.key, required this.orderid});

  @override
  State<CustomerOrderStatus> createState() => _CustomerOrderStatusState();
}

class _CustomerOrderStatusState extends State<CustomerOrderStatus> {
  Order? _orderdetail;
  List<OrderItem> _orderItemList = [];
  int? _estimatedPrepTime;
  int? _queueLength;
  bool _isLoadingOrderItems = true;
  String? _orderItemsError;
  Timer? _refreshTimer;

  Future<void> _fetchOrderItems({bool showLoading = true}) async {
    if (showLoading) {
      setState(() {
        _isLoadingOrderItems = true;
        _orderItemsError = null;
      });
    }

    try {
      final orderfromid = await client.order.getOrderById(
        widget.orderid,
      );
      if (mounted) {
        setState(() {
          _orderItemList = orderfromid.orderItems;
          _orderdetail = orderfromid.order;
          _estimatedPrepTime = orderfromid.estimatedPrepTime;
          _queueLength = orderfromid.queueLength;
          _isLoadingOrderItems = false;
          _orderItemsError = null;
        });
      }
    } catch (e) {
      debugPrint('Failed to fetch order items: $e');
      if (mounted) {
        setState(() {
          if (_orderdetail == null) {
            _orderItemsError = 'ไม่สามารถโหลดรายการอาหารได้';
            _isLoadingOrderItems = false;
          }
        });
      }
    }
  }

  void _startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _fetchOrderItems(showLoading: false);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchOrderItems();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _onCancelOrder() async {
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
              onPressed: () async {
                Navigator.of(context).pop();

                Order neworderdetail = await client.order.cancelMyOrder(
                  widget.orderid,
                );
                if (!mounted) return;
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
    final hasQueueOrPrepInfo =
        _queueLength != null || _estimatedPrepTime != null;

    // Show loading state while fetching data
    if (_isLoadingOrderItems) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "รายการออเดอร์",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Show error state if data fetch failed
    if (_orderItemsError != null || _orderdetail == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "รายการออเดอร์",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_orderItemsError ?? 'ไม่พบข้อมูลออเดอร์'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _fetchOrderItems(),
                child: const Text('ลองใหม่'),
              ),
            ],
          ),
        ),
      );
    }
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
                child: SingleChildScrollView(
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
                  Row(
                    mainAxisAlignment: hasQueueOrPrepInfo
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      if (hasQueueOrPrepInfo)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_queueLength != null)
                              Text("จำนวนคิวก่อนหน้า $_queueLength คิว"),
                            if (_estimatedPrepTime != null)
                              Text("เวลาประมาณ $_estimatedPrepTime นาที"),
                          ],
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "ราคารวม",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
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
                      onPressed: _orderdetail!.status != OrderStatus.received
                          ? _onCancelOrder
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
            )
          : null,
    );
  }
}
