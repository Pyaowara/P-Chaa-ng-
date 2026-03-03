import 'package:serverpod/serverpod.dart' hide Order;
import '../generated/protocol.dart';
import 'fcm_service.dart';

class NotificationUtils {
  /// Send order status update notification to the order owner
  static Future<void> sendOrderStatusNotification({
    required Session session,
    required int userId,
    required Order order,
    required OrderStatus newStatus,
    String? replyMessage,
  }) async {
    try {
      // Get all FCM tokens for the user
      final tokens = await FcmToken.db.find(
        session,
        where: (t) => t.userId.equals(userId),
      );

      if (tokens.isEmpty) {
        session.log(
          '[NotificationUtils] No FCM tokens found for userId: $userId',
        );
        return;
      }

      // Determine notification content based on status transition
      final notificationContent = _getNotificationContent(
        newStatus: newStatus,
        order: order,
        replyMessage: replyMessage,
      );

      // Send notification to all tokens
      for (final tokenRecord in tokens) {
        try {
          await FcmService.instance.sendNotification(
            token: tokenRecord.token,
            title: notificationContent['title']!,
            body: notificationContent['body']!,
            data: {
              'type': 'order_status_update',
              'orderId': order.id.toString(),
              'queueNumber': order.queueNumber ?? '',
              'status': newStatus.toString().split('.').last,
              'orderType': order.type.toString().split('.').last,
            },
          );
          session.log(
            '[NotificationUtils] Order status notification sent to userId: $userId',
          );
        } catch (e) {
          session.log(
            '[NotificationUtils] Failed to send notification to token: $e',
          );
        }
      }
    } catch (e) {
      session.log(
        '[NotificationUtils] Error sending order status notification: $e',
      );
    }
  }

  /// Get localized notification content based on status
  static Map<String, String> _getNotificationContent({
    required OrderStatus newStatus,
    required Order order,
    String? replyMessage,
  }) {
    final queueDisplay = order.queueNumber ?? '';
    
    switch (newStatus) {
      case OrderStatus.confirmed:
        return {
          'title': 'คำสั่งซื้อได้รับการยืนยันแล้ว',
          'body': queueDisplay.isNotEmpty 
              ? 'เลขคิว: $queueDisplay\nกำลังรอการเตรียมอาหาร' 
              : 'คำสั่งซื้อได้รับการยืนยันแล้ว',
        };
      case OrderStatus.preparing:
        return {
          'title': 'คำสั่งซื้อได้รับการยืนยันแล้ว',
          'body': queueDisplay.isNotEmpty 
              ? 'เลขคิว: $queueDisplay\nกำลังเตรียมอาหารของคุณ' 
              : 'คำสั่งซื้อกำลังเตรียมอาหาร',
        };
      case OrderStatus.finished:
        return {
          'title': 'อาหารพร้อมแล้ว',
          'body': queueDisplay.isNotEmpty 
              ? 'เลขคิว: $queueDisplay\nพร้อมรับได้แล้ว' 
              : 'อาหารของคุณพร้อมรับได้แล้ว',
        };
      case OrderStatus.received:
        return {
          'title': 'คำสั่งซื้อเสร็จสิ้น',
          'body': 'ขอบคุณที่ซื้อสินค้าจากเรา ยินดีให้บริการครั้งหน้า',
        };
      case OrderStatus.cancelled:
        return {
          'title': 'คำสั่งซื้อถูกยกเลิก',
          'body': replyMessage ?? 'คำสั่งซื้อของคุณถูกยกเลิกโดยเจ้าของร้าน',
        };
      case OrderStatus.ordered:
        return {
          'title': 'คำสั่งซื้อใหม่',
          'body': 'คำสั่งซื้อได้รับการบันทึก',
        };
    }
  }
}
