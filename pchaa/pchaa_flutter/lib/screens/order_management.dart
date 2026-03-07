import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/services/owner_order_services.dart';
import 'package:pchaa_flutter/widgets/order_manage/index.dart';

class OrderManagementPage extends StatefulWidget {
  final int orderId;
  final Order? order;
  final String? userName;

  const OrderManagementPage({
    super.key,
    required this.orderId,
    this.order,
    this.userName,
  });

  @override
  State<OrderManagementPage> createState() => _OrderManagementPageState();
}

class _OrderManagementPageState extends State<OrderManagementPage> {
  final OwnerOrderService _orderService = OwnerOrderService();
  late Order _currentOrder;
  late String? _userName;
  List<OrderItem> _orderItems = [];
  bool _isLoading = true;
  bool _isUpdating = false;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _userName = widget.userName;
    if (widget.order != null) {
      _currentOrder = widget.order!;
    }
    _loadOrderDetails();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadOrderDetails({bool showLoading = true}) async {
    if (showLoading) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final items = await _orderService.getOrderItems(widget.orderId);
      if (mounted) {
        setState(() {
          _orderItems = items;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading order details: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        if (showLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading order details: $e')),
          );
        }
      }
    }
  }

  void _startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _loadOrderDetails(showLoading: false);
    });
  }

  void _showConfirmationDialog(OrderStatus newStatus) {
    OrderDialogs.showConfirmationDialog(
      context: context,
      newStatus: newStatus,
      onConfirm: () => _updateOrderStatus(newStatus),
    );
  }

  void _showReplyMessageDialog(OrderStatus newStatus) {
    OrderDialogs.showReplyMessageDialog(
      context: context,
      onConfirm: (replyMessage) => _updateOrderStatus(
        newStatus,
        replyMessage: replyMessage,
      ),
    );
  }

  Future<void> _updateOrderStatus(OrderStatus newStatus, {String? replyMessage}) async {
    setState(() {
      _isUpdating = true;
    });
    try {
      late Order updatedOrder;
      
      // Handle ordered status with confirmOrder method
      if (_currentOrder.status == OrderStatus.ordered && 
          newStatus == OrderStatus.confirmed) {
        updatedOrder = await _orderService.confirmOrder(widget.orderId);
      } else {
        // Use updateOrderStatus for other transitions
        updatedOrder = await _orderService.updateOrderStatus(
          widget.orderId,
          newStatus,
          replyMessage: newStatus == OrderStatus.cancelled ? replyMessage : null,
        );
      }
      
      if (mounted) {
        setState(() {
          _currentOrder = updatedOrder;
          _isUpdating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Order status updated to ${OrderConstants.formatOrderStatus(newStatus)}',
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error updating order status: $e');
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating order: $e')),
        );
      }
    }
  }

  List<OrderStatus> _getAvailableNextStatuses() {
    switch (_currentOrder.status) {
      case OrderStatus.ordered:
        return [
          OrderStatus.cancelled,
          OrderStatus.confirmed,
        ];
      case OrderStatus.confirmed:
        return [
          OrderStatus.cancelled,
          OrderStatus.preparing,
        ];
      case OrderStatus.preparing:
        return [
          OrderStatus.cancelled,
          OrderStatus.finished,
        ];
      case OrderStatus.finished:
        return [
          OrderStatus.cancelled,
          OrderStatus.received,
        ];
      case OrderStatus.received:
        return [];
      case OrderStatus.cancelled:
        return [];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          _currentOrder.queueNumber != null
              ? 'Queue: ${_currentOrder.queueNumber}'
              : 'Order #${widget.orderId}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: OrderDetailsContent(
                    order: _currentOrder,
                    items: _orderItems,
                    userName: _userName,
                  ),
                ),
                OrderStatusButtonsSection(
                  availableStatuses: _getAvailableNextStatuses(),
                  isUpdating: _isUpdating,
                  onStatusSelected: (status) {
                    if (status == OrderStatus.cancelled) {
                      _showReplyMessageDialog(status);
                    } else {
                      _showConfirmationDialog(status);
                    }
                  },
                ),
              ],
            ),
    );
  }
}
