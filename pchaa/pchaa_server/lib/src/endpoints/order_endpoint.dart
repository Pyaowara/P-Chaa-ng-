import 'package:pchaa_server/src/utils/order_utils.dart';
import 'package:serverpod/serverpod.dart' hide Order;
import '../generated/protocol.dart';
import '../utils/auth_utils.dart';
import '../utils/menu_items_utils.dart';
import '../utils/thailand_time_utils.dart';
import '../utils/queue_utils.dart';
import '../utils/notification_utils.dart';

class OrderEndpoint extends Endpoint {
  
   Future<Order> createOrder(Session session, OrderType orderType, DateTime? pickupTime) async {
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
        finalPrice: cart.totalPrice,
        additionalMessage: cart.additionalMessage,
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
    order.status = OrderStatus.confirmed;
    final newQueueNumber = await QueueUtils.newQueue(session, order.type == OrderType.I ? 'i' : 's');
    order.queueNumber = "${order.type}${newQueueNumber.toString().padLeft(3, '0')}";
    await Order.db.update(session, [order]);
    session.log("[OrderEndpoint] Updated order status for ${order.queueNumber} to status: ${order.status}");
    
    // Send notification to order owner
    await NotificationUtils.sendOrderStatusNotification(
      session: session,
      userId: order.userId,
      order: order,
      newStatus: OrderStatus.confirmed,
    );
    
    return order;
  }

  Future<Order> updateOrderStatus(Session session, int orderId, OrderStatus newStatus, String? replymessage) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);
    
    final order = await Order.db.findById(session, orderId);
    if (order == null) {
      throw Exception('Order not found');
    }
    if (order.status == OrderStatus.cancelled || order.status == OrderStatus.received) {
      throw Exception('Cannot change status of a cancelled or received order');
    }
    if (newStatus == OrderStatus.ordered) {
      throw Exception('Cannot change order status to $newStatus directly');
    }
    if (replymessage != null && newStatus != OrderStatus.cancelled) {
      throw Exception('Reply message can only be provided when cancelling an order');
    }
    
    // Validate status transitions
    switch ((order.status, newStatus)) {
      case (OrderStatus.ordered, OrderStatus.confirmed):
      case (OrderStatus.confirmed, OrderStatus.preparing):
      case (OrderStatus.preparing, OrderStatus.finished):
      case (OrderStatus.finished, OrderStatus.received):
      case (_, OrderStatus.cancelled):
        break;
      default:
        throw Exception('Invalid status transition from ${order.status} to $newStatus');
    }
    
    order.status = newStatus;
    if (newStatus == OrderStatus.cancelled) {
      order.replyMessage = replymessage?.isNotEmpty == true 
          ? replymessage 
          : "Your order has been cancelled by the owner.";
    }
    
    await Order.db.update(session, [order]);
    session.log("[OrderEndpoint] Updated order status for ${order.queueNumber} to status: ${order.status}");
    
    // Send notification to order owner
    await NotificationUtils.sendOrderStatusNotification(
      session: session,
      userId: order.userId,
      order: order,
      newStatus: newStatus,
      replyMessage: replymessage,
    );
    
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
    if (order.status == OrderStatus.received) {
      throw Exception('Can not cancel order when order status is received');
    }
    order.status = OrderStatus.cancelled;
    await Order.db.update(session, [order]);
    session.log("[OrderEndpoint] Cancelled order with id: ${order.id} for userId: ${user.id}");
    return order;
  }

  Future<List<Order>> getMyOrders(Session session) async {
    final user = await AuthUtils.allowedRoles(session, [UserRole.user]);
    final today = ThailandTimeUtils.getThailandDate();
    final orders = await Order.db.find(
      session,
      where: (t) => t.userId.equals(user.id!) & t.orderDate.equals(today),
    );
    session.log("[OrderEndpoint] Fetched orders for userId: ${user.id}");
    return orders;
  }
  Future<EstimatedQueue> getEstimatedQueue(Session session) async {
    await AuthUtils.allowedRoles(session, [UserRole.user, UserRole.owner]);
    var result = await OrderUtils.getEstimatedTimeForNewOrder(session);
    return EstimatedQueue(
      estimatedPrepTime: result['estimatedPrepTime']!,
      queueLength: result['queueLength']!,
    );
  }
  Future<OrderWithEstimated> getOrderById(Session session, int orderId) async {
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
    int? estimatedPrepTime;
    int? queueLength;
    if (order.type == OrderType.I && order.queueNumber != null && (order.status == OrderStatus.preparing || order.status == OrderStatus.confirmed)) {
      var estimated = await OrderUtils.calculateEstimatedPrepTime(session, orderId);
      estimatedPrepTime = estimated['estimatedPrepTime'];
      queueLength = estimated['queueLength'];
    }
    session.log("[OrderEndpoint] Fetched order with id: $orderId for userId: ${user.id}");
    return OrderWithEstimated(
      order: order,
      orderItems: orderItems,
      estimatedPrepTime: estimatedPrepTime,
      queueLength: queueLength,
    );
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

  Future<List<OrderWithUserName>> getTodayOrder(Session session) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);
    
    final today = ThailandTimeUtils.getThailandDate();
    var orders = <Order>[];
    final orderedOrder = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.ordered),
      orderBy: (order) => order.createdAt,
    );
    final orderConfirmed = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.confirmed),
      orderBy: (order) => order.queueNumber,
    );
    final preparingOrder = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.preparing),
      orderBy: (order) => order.queueNumber,
    );
    final finishedOrder = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.finished),
      orderBy: (order) => order.queueNumber,
    );
    final receivedOrder = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.received),
      orderBy: (order) => order.queueNumber,
    );
    final cancelledOrder = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.cancelled),
      orderBy: (order) => order.createdAt,
    );
    orders.addAll(orderedOrder);
    orders.addAll(orderConfirmed);
    orders.addAll(preparingOrder);
    orders.addAll(finishedOrder);
    orders.addAll(receivedOrder);
    orders.addAll(cancelledOrder);

    // Fetch user data for each order
    var result = <OrderWithUserName>[];
    for (var order in orders) {
      final user = await User.db.findById(session, order.userId);
      result.add(OrderWithUserName(
        order: order,
        userName: user?.fullName ?? 'Unknown User',
      ));
    }

    session.log("[OrderEndpoint] Fetched today's order for date: $today");
    return result;
  }

  Future<List<OrderWithUserName>> getFinishedOrder(Session session) async {
    
    final today = ThailandTimeUtils.getThailandDate();
    final finishedOrders = await Order.db.find(
      session,
      where: (t) => t.orderDate.equals(today) & t.status.equals(OrderStatus.finished),
      orderBy: (order) => order.queueNumber,
    );

    // Fetch user data for each order
    var result = <OrderWithUserName>[];
    for (var order in finishedOrders) {
      final user = await User.db.findById(session, order.userId);
      result.add(OrderWithUserName(
        order: order,
        userName: user?.fullName ?? 'Unknown User',
      ));
    }

    session.log("[OrderEndpoint] Fetched finished orders for date: $today");
    return result;
  }

  
}