import 'package:pchaa_server/src/utils/thailand_time_utils.dart';
import 'package:serverpod/serverpod.dart' hide Order;
import '../generated/protocol.dart';

class OrderUtils {
  static Future<Map<String, int>> calculateEstimatedPrepTime(
    Session session,
    int orderId,
  ) async {
    final today = ThailandTimeUtils.getThailandDate();
    final order = await Order.db.findById(session, orderId);
    if (order == null) {
      throw Exception('Order not found');
    }
    if (order.type == OrderType.S){
      throw Exception('Estimated time calculation not applicable for scheduled orders');
    }
    final beforeOrder = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.type.equals(OrderType.I) & t.status.inSet({OrderStatus.preparing, OrderStatus.confirmed}) & (t.queueNumber < order.queueNumber),
      orderBy: (t) => t.queueNumber,
    );
    final orderItems = await OrderItem.db.find(
      session,
      where: (t) => t.orderId.equals(order.id!),
    );
    int totalPrepTime = 0;
    for (var before in beforeOrder) {
      final items = await OrderItem.db.find(
        session,
        where: (t) => t.orderId.equals(before.id!),
      );
      for (var item in items) {
        final menuItem = await MenuItem.db.findById(session, item.menuItemId!);
        if (menuItem == null) {
          throw Exception('Menu item not found for order item ${item.id}');
        }
        totalPrepTime += menuItem.timeToPrepare * item.quantity;
      }
    }
    int thisOrderPrepTime = 0;
    for (var orderItem in orderItems) {
      final menuItem = await MenuItem.db.findById(session, orderItem.menuItemId!);
      if (menuItem == null) {
        throw Exception('Menu item not found for order item ${orderItem.id}');
      }
      thisOrderPrepTime += menuItem.timeToPrepare * orderItem.quantity;
      
    }
    // For simplicity, we return a fixed estimated delivery time.
    // In a real-world scenario, this could be based on various factors.
    return {
      'estimatedPrepTime': totalPrepTime + thisOrderPrepTime,
      'queueLength': beforeOrder.length,
    };
  }

  static Future<Map<String, int>> getEstimatedTimeForNewOrder(
    Session session,
  ) async {
    final today = ThailandTimeUtils.getThailandDate();
    final ongoingOrders = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.type.equals(OrderType.I) & t.status.inSet({OrderStatus.preparing, OrderStatus.confirmed}),
      orderBy: (t) => t.queueNumber,
    );
    int totalPrepTime = 0;
    for (var order in ongoingOrders) {
      final items = await OrderItem.db.find(
        session,
        where: (t) => t.orderId.equals(order.id!),
      );
      for (var item in items) {
        if (item.menuItemId == null) {
          throw Exception('Menu item ID is null for order item ${item.id}');
        }
        final menuItem = await MenuItem.db.findById(session, item.menuItemId!);
        if (menuItem == null) {
          throw Exception('Menu item not found for order item ${item.id}');
        }
        totalPrepTime += menuItem.timeToPrepare * item.quantity;
      }
    }
    var result = <String, int>{};
    result['estimatedPrepTime'] = totalPrepTime;
    result['queueLength'] = ongoingOrders.length;
    return result;
  }
}