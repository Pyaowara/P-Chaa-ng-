import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/screens/order_management.dart';
import 'package:pchaa_flutter/services/owner_order_services.dart';
import 'package:pchaa_flutter/widgets/order_manage/index.dart';
import 'package:pchaa_flutter/widgets/order_list/order_list_filters.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final OwnerOrderService _orderService = OwnerOrderService();
  OrderType? _selectedType;
  OrderStatus? _selectedStatus;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadOrders();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadOrders({bool showLoading = true}) async {
    try {
      await _orderService.fetchTodayOrders();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error loading orders: $e');
      if (mounted && showLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading orders: $e')),
        );
      }
    }
  }

  void _startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _loadOrders(showLoading: false);
    });
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
                    OrderListFilters(
                      selectedType: _selectedType,
                      selectedStatus: _selectedStatus,
                      onTypeChanged: (value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                      onStatusChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      },
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
                          userName: _orderService.getUserNameForOrder(
                            order.id!,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderManagementPage(
                                  orderId: order.id!,
                                  order: order,
                                  userName: _orderService.getUserNameForOrder(
                                    order.id!,
                                  ),
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
