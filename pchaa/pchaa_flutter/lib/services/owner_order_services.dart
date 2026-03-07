import 'package:flutter/foundation.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';

/// OwnerOrderService manages orders from the owner's perspective
class OwnerOrderService extends ChangeNotifier {
  List<Order> _todayOrders = [];
  Map<int, List<OrderItem>> _orderItemsCache = {};
  Map<int, String> _orderUserNames = {}; // Map to store order ID to username
  bool _loading = false;
  String? _error;

  List<Order> get todayOrders => _todayOrders;
  bool get isLoading => _loading;
  String? get error => _error;

  /// Get username for an order
  String? getUserNameForOrder(int orderId) => _orderUserNames[orderId];

  /// Fetch all orders for today
  Future<List<Order>> fetchTodayOrders() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await client.order.getTodayOrder();
      // Extract orders and usernames from response
      _todayOrders = [];
      _orderUserNames.clear();
      for (var item in response) {
        final order = item.order;
        final userName = item.userName;
        _todayOrders.add(order);
        if (order.id != null && userName != null) {
          _orderUserNames[order.id!] = userName;
        }
      }
      return _todayOrders;
    } catch (e) {
      _error = e.toString();
      debugPrint('Error fetching today orders: $e');
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Get order items for a specific order
  Future<List<OrderItem>> getOrderItems(int orderId) async {
    try {
      // Check cache first
      if (_orderItemsCache.containsKey(orderId)) {
        return _orderItemsCache[orderId]!;
      }

      final items = await client.order.getOrderItems(orderId);
      _orderItemsCache[orderId] = items;
      return items;
    } catch (e) {
      _error = e.toString();
      debugPrint('Error fetching order items: $e');
      rethrow;
    }
  }

  /// Confirm an order (from ordered status)
  Future<Order> confirmOrder(int orderId) async {
    try {
      final confirmedOrder = await client.order.confirmOrder(orderId);

      // Update the local list
      final index = _todayOrders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        _todayOrders[index] = confirmedOrder;
        notifyListeners();
      }

      return confirmedOrder;
    } catch (e) {
      _error = e.toString();
      debugPrint('Error confirming order: $e');
      rethrow;
    }
  }

  /// Update order status
  Future<Order> updateOrderStatus(
    int orderId,
    OrderStatus newStatus, {
    String? replyMessage,
  }) async {
    try {
      final updatedOrder = await client.order.updateOrderStatus(
        orderId,
        newStatus,
        replyMessage,
      );

      // Update the local list
      final index = _todayOrders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        _todayOrders[index] = updatedOrder;
        notifyListeners();
      }

      return updatedOrder;
    } catch (e) {
      _error = e.toString();
      debugPrint('Error updating order status: $e');
      rethrow;
    }
  }
}
