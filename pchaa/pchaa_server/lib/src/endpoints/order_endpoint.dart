import 'package:pchaa_server/src/utils/order_utils.dart';
import 'package:serverpod/serverpod.dart' hide Order;
import '../generated/protocol.dart';
import '../utils/auth_utils.dart';
import '../utils/menu_items_utils.dart';
import '../utils/thailand_time_utils.dart';
import '../utils/queue_utils.dart';

class OrderEndpoint extends Endpoint {
  
   Future<Order> createOrder(Session session, String? replyMessage, OrderType orderType, DateTime? pickupTime) async {
    final user = await AuthUtils.allowedRoles(session, [UserRole.user]);

    final mycarts = await Cart.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
    if (mycarts.isEmpty) {
      throw Exception('No items in cart to create an order');
    }
    if (orderType == OrderType.S) {
      if (pickupTime == null) {
        throw Exception('Pickup time must be provided for scheduled orders');
      }
      if (pickupTime.isBefore(ThailandTimeUtils.getThailandNow())) {
        throw Exception('Pickup time must be in the future');
      }
      else if (pickupTime.difference(ThailandTimeUtils.getThailandNow()).inDays >= 1) {
        throw Exception('Pickup time must be within the same day');
      }
    }

    double orderTotal = 0.0;
    for (var cart in mycarts) {
      final menuItem = await MenuItem.db.findById(session, cart.menuItemId);
      if (menuItem == null || !menuItem.isAvailable || menuItem.isDeleted) {
        throw Exception('Menu item in cart is no longer available');
      }
      await MenuItemsUtils.checkMenuAvailable(session, cart.menuItemId, cart.selectedOptions);
      orderTotal += cart.totalPrice;
    }
    final order = Order(
      userId: user.id!, 
      status: OrderStatus.ordered, 
      type: orderType, 
      pickupTime: orderType == OrderType.S ? pickupTime : null,
      totalOrderPrice: orderTotal, 
      orderDate: ThailandTimeUtils.getThailandDate(),
      replyMessage: replyMessage,
      createdAt: ThailandTimeUtils.getThailandNow()
    );
    final createdOrder = await Order.db.insert(session, [order]);
    for (var cart in mycarts) {
      var menuItem = await MenuItem.db.findById(session, cart.menuItemId);
      if (menuItem == null) {
        throw Exception('Menu item in cart is no longer available');
      }
      final orderItem = OrderItem(
        menuItemId: menuItem.id!,
        orderId: createdOrder.first.id!, 
        itemName: menuItem.name, 
        selectedOptions: cart.selectedOptions, 
        quantity: cart.quantity, 
        finalPrice: cart.totalPrice
      );
      await OrderItem.db.insert(session, [orderItem]);
    }
    await Cart.db.delete(
      session,
      mycarts,
    );
    session.log("[OrderEndpoint] Created immediate order with id: ${createdOrder.first.id} for userId: ${user.id}");
    return createdOrder.first;
  }

  Future<Order> confirmOrder(Session session, int orderId) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);
    
    final order = await Order.db.findById(session, orderId);
    if (order == null) {
      throw Exception('Order not found');
    }
    if (order.status != OrderStatus.ordered) {
      throw Exception('Only orders with status "ordered" can be confirmed');
    }
    order.status = OrderStatus.preparing;
    final newQueueNumber = await QueueUtils.newQueue(session, order.type == OrderType.I ? 'i' : 's');
    order.queueNumber = "${order.type}${newQueueNumber.toString().padLeft(3, '0')}";
    await Order.db.update(session, [order]);
    session.log("[OrderEndpoint] Updated order status for ${order.queueNumber} to status: ${order.status}");
    return order;
  }

  Future<Order> updateOrderStatus(Session session, int orderId, OrderStatus newStatus) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);
    
    final order = await Order.db.findById(session, orderId);
    if (order == null) {
      throw Exception('Order not found');
    }
    if (order.status == OrderStatus.cancelled || order.status == OrderStatus.received) {
      throw Exception('Cannot change status of a cancelled or received order');
    }
    else if (newStatus == OrderStatus.ordered) {
      throw Exception('Cannot change order status to $newStatus directly');
    }
    // Validate status transitions
    if (order.status == OrderStatus.ordered && newStatus != OrderStatus.preparing) {
      throw Exception('Invalid status transition from ordered to $newStatus');
    }
    else if (order.status == OrderStatus.preparing && newStatus != OrderStatus.finished) {
      throw Exception('Invalid status transition from preparing to $newStatus');
    }
    else if (order.status == OrderStatus.finished && newStatus != OrderStatus.received) {
      throw Exception('Invalid status transition from finished to $newStatus');
    }
    order.status = newStatus;
    await Order.db.update(session, [order]);
    session.log("[OrderEndpoint] Updated order status for ${order.queueNumber} to status: ${order.status}");
    return order;
  }

  Future<Order> cancelMyOrder(Session session, int orderId) async {
    final user = await AuthUtils.allowedRoles(session, [UserRole.user]);
    
    final order = await Order.db.findById(session, orderId);
    if (order == null) {
      throw Exception('Order not found');
    }
    if (order.userId != user.id!) {
      throw Exception('Access denied: Can\'t cancel order of another user');
    }
    if (order.status != OrderStatus.ordered) {
      throw Exception('Only orders with status "ordered" can be cancelled');
    }
    order.status = OrderStatus.cancelled;
    await Order.db.update(session, [order]);
    session.log("[OrderEndpoint] Cancelled order with id: ${order.id} for userId: ${user.id}");
    return order;
  }

  Future<List<Order>> getMyOrders(Session session) async {
    final user = await AuthUtils.allowedRoles(session, [UserRole.user]);
    
    final orders = await Order.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
    session.log("[OrderEndpoint] Fetched orders for userId: ${user.id}");
    return orders;
  }
  Future <Map<String, int>> getEstimatedQueue(Session session) async {
    await AuthUtils.allowedRoles(session, [UserRole.user, UserRole.owner]);
    var result = await OrderUtils.getEstimatedTimeForNewOrder(session);
    return result;
  }
  Future<Map<String, dynamic>> getOrderById(Session session, int orderId) async {
    final user = await AuthUtils.allowedRoles(session, [UserRole.user, UserRole.owner]);
    
    final order = await Order.db.findById(session, orderId);
    if (order == null) {
      throw Exception('Order not found');
    }
    if (order.userId != user.id! && user.role == UserRole.user) {
      throw Exception('Access denied: Can\'t access order of another user');
    }

    final orderItems = await OrderItem.db.find(
      session,
      where: (t) => t.orderId.equals(orderId),
    );
    var result = <String, dynamic>{};
    result['order'] = order;
    result['orderItems'] = orderItems;
    if (order.type == OrderType.I && order.queueNumber != null && (order.status == OrderStatus.preparing || order.status == OrderStatus.confirmed)) {
      var estimated = await OrderUtils.calculateEstimatedPrepTime(session, orderId);
      result['estimatedPrepTime'] = estimated['estimatedPrepTime'];
      result['queueLength'] = estimated['queueLength'];
    }
    session.log("[OrderEndpoint] Fetched order with id: $orderId for userId: ${user.id}");
    return result;
  }

  Future<List<OrderItem>> getOrderItems(Session session, int orderId) async {
    final user = await AuthUtils.allowedRoles(session, [UserRole.user, UserRole.owner]);
    
    final order = await Order.db.findById(session, orderId);
    if (order == null) {
      throw Exception('Order not found');
    }
    if (order.userId != user.id! && user.role == UserRole.user) {
      throw Exception('Access denied: Can\'t access order of another user');
    }

    final orderItems = await OrderItem.db.find(
      session,
      where: (t) => t.orderId.equals(orderId),
    );
    session.log("[OrderEndpoint] Fetched order items for orderId: $orderId and userId: ${user.id}");
    return orderItems;
  }

  Future<List<Order>> getTodayOrder(Session session) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);
    
    final today = ThailandTimeUtils.getThailandDate();
    var orders = <Order>[];
    final orderedOrder = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.ordered),
      orderBy: (order) => order.createdAt,
    );
    orders.addAll(orderedOrder);
    final preparingOrder = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.preparing),
      orderBy: (order) => order.queueNumber,
    );
    orders.addAll(preparingOrder);
    final finishedOrder = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.finished),
      orderBy: (order) => order.queueNumber,
    );
    orders.addAll(finishedOrder);
    final receivedOrder = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.received),
      orderBy: (order) => order.queueNumber,
    );
    orders.addAll(receivedOrder);
    final cancelledOrder = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.cancelled),
      orderBy: (order) => order.createdAt,
    );
    orders.addAll(cancelledOrder);

    session.log("[OrderEndpoint] Fetched today's order for date: $today");
    return orders;
  }

  Future<List<Order>> getFinishedOrders(Session session, OrderType type) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);
    
    final orders = await Order.db.find(
      session,
      where: (t) => t.type.equals(type) & t.status.equals(OrderStatus.finished),
      orderBy: (order) => order.queueNumber,
    );
    session.log("[OrderEndpoint] Fetched finished orders of type: $type");
    return orders;
  }

  Future<List<Order>> getTodayOrderByType(Session session, OrderType type, OrderStatus? status) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);
    
    final today = ThailandTimeUtils.getThailandDate();
    final orders = await Order.db.find(
      session,
      where: (t) => status != null 
        ? t.orderDate.equals(today) & t.status.equals(status) & t.type.equals(type)
        : t.orderDate.equals(today) & t.type.equals(type),
      orderBy: (order) => order.queueNumber,
    );
    
    session.log("[OrderEndpoint] Fetched today's order of status: $status for date: $today");
    return orders;
  }

 



}