import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/fcm_service.dart';
import '../utils/auth_utils.dart';

class NotificationEndpoint extends Endpoint {
  Future<bool> registerToken(
    Session session,
    String token, {
    String? deviceInfo,
  }) async {
    final user = await AuthUtils.isAuthenticated(session);
    final userId = user.id!;

    final existing = await FcmToken.db.findFirstRow(
      session,
      where: (t) => t.token.equals(token),
    );

    if (existing != null) {
      final updated = existing.copyWith(
        userId: userId,
        deviceInfo: deviceInfo,
        updatedAt: DateTime.now(),
      );
      await FcmToken.db.updateRow(session, updated);
      session.log('[NotificationEndpoint] Updated FCM token for user $userId');
    } else {
      final fcmToken = FcmToken(
        userId: userId,
        token: token,
        deviceInfo: deviceInfo,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await FcmToken.db.insertRow(session, fcmToken);
      session.log(
        '[NotificationEndpoint] Registered new FCM token for user $userId',
      );
    }

    return true;
  }

  Future<bool> removeToken(Session session, String token) async {
    await AuthUtils.isAuthenticated(session);

    final rows = await FcmToken.db.find(
      session,
      where: (t) => t.token.equals(token),
    );

    for (final row in rows) {
      await FcmToken.db.deleteRow(session, row);
    }

    session.log('[NotificationEndpoint] Removed FCM token(s)');
    return true;
  }

  Future<bool> sendLoginNotification(Session session) async {
    final user = await AuthUtils.isAuthenticated(session);
    final userName = user.fullName;

    final owners = await User.db.find(
      session,
      where: (t) => t.role.equals(UserRole.owner),
    );

    if (owners.isEmpty) {
      session.log('[NotificationEndpoint] No owner users found to notify');
      return false;
    }

    for (final owner in owners) {
      final tokens = await FcmToken.db.find(
        session,
        where: (t) => t.userId.equals(owner.id!),
      );
      session.log(
        '[NotificationEndpoint] Found ${tokens.length} tokens for owner ${owner.id}',
      );
      for (final tokenRecord in tokens) {
        try {
          await FcmService.instance.sendNotification(
            token: tokenRecord.token,
            title: 'ผู้ใช้เข้าสู่ระบบ',
            body: '$userName ได้เข้าสู่ระบบแอปแล้ว',
            data: {
              'type': 'user_login',
              'userId': user.id.toString(),
              'userName': userName,
            },
          );
          session.log(
            '[NotificationEndpoint] Login notification sent to owner ${owner.email}',
          );
        } catch (e) {
          session.log(
            '[NotificationEndpoint] Failed to send notification: $e',
            level: LogLevel.error,
          );
        }
      }
    }

    return true;
  }
}
