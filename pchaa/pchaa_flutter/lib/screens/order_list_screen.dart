import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/screens/order_management.dart';
import 'package:pchaa_flutter/services/owner_order_services.dart';
import 'package:pchaa_flutter/widgets/order_manage/index.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final OwnerOrderService _orderService = OwnerOrderService();
  OrderType? _selectedType;
  OrderStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      await _orderService.fetchTodayOrders();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error loading orders: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading orders: $e')),
        );
      }
    }
  }

  Future<void> _refreshOrders() async {
    await _loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'รายการสั่งซื้อ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshOrders,
        color: AppColors.primary,
        child: _orderService.isLoading && _orderService.todayOrders.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),
              )
            : _orderService.todayOrders.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 64,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'ไม่มีรายการสั่งซื้อวันนี้',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Filters in one row
                        Row(
                          children: [
                            // Filter by type
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'ประเภท',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  DropdownButton<OrderType?>(
                                    value: _selectedType,
                                    isExpanded: true,
                                    underline: Container(
                                      height: 2,
                                      color: AppColors.primary,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: null,
                                        child: const Text('ทั้งหมด', style: TextStyle(fontSize: 13)),
                                      ),
                                      DropdownMenuItem(
                                        value: OrderType.I,
                                        child: const Text('สั่งทันที', style: TextStyle(fontSize: 13)),
                                      ),
                                      DropdownMenuItem(
                                        value: OrderType.S,
                                        child: const Text('สั่งกำหนด', style: TextStyle(fontSize: 13)),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedType = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Filter by status
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'สถานะ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  DropdownButton<OrderStatus?>(
                                    value: _selectedStatus,
                                    isExpanded: true,
                                    underline: Container(
                                      height: 2,
                                      color: AppColors.primary,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: null,
                                        child: const Text('ทั้งหมด', style: TextStyle(fontSize: 13)),
                                      ),
                                      DropdownMenuItem(
                                        value: OrderStatus.ordered,
                                        child: const Text('สั่งแล้ว', style: TextStyle(fontSize: 13)),
                                      ),
                                      DropdownMenuItem(
                                        value: OrderStatus.confirmed,
                                        child: const Text('ยืนยัน', style: TextStyle(fontSize: 13)),
                                      ),
                                      DropdownMenuItem(
                                        value: OrderStatus.preparing,
                                        child: const Text('เตรียม', style: TextStyle(fontSize: 13)),
                                      ),
                                      DropdownMenuItem(
                                        value: OrderStatus.finished,
                                        child: const Text('เสร็จ', style: TextStyle(fontSize: 13)),
                                      ),
                                      DropdownMenuItem(
                                        value: OrderStatus.received,
                                        child: const Text('รับแล้ว', style: TextStyle(fontSize: 13)),
                                      ),
                                      DropdownMenuItem(
                                        value: OrderStatus.cancelled,
                                        child: const Text('ยกเลิก', style: TextStyle(fontSize: 13)),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedStatus = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Orders list
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _orderService.todayOrders.length,
                          itemBuilder: (context, index) {
                            final order = _orderService.todayOrders[index];

                            // Filter by type if selected
                            if (_selectedType != null &&
                                order.type != _selectedType) {
                              return const SizedBox.shrink();
                            }

                            // Filter by status if selected
                            if (_selectedStatus != null &&
                                order.status != _selectedStatus) {
                              return const SizedBox.shrink();
                            }

                            return OrderCard(
                              order: order,
                              userName: _orderService.getUserNameForOrder(order.id!),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderManagementPage(
                                      orderId: order.id!,
                                      order: order,
                                      userName: _orderService.getUserNameForOrder(order.id!),
                                    ),
                                  ),
                                ).then((_) {
                                  _refreshOrders();
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
