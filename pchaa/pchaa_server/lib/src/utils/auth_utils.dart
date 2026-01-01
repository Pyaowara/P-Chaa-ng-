import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import '../generated/protocol.dart';

class AuthUtils {
  static Future<void> isAuthenticated(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User not authenticated');
    }
  }

  static Future<User> allowedRoles(
    Session session,
    List<UserRole> roles,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User not authenticated');
    }

    final authUserInfo = await auth.Users.findUserByUserId(
      session,
      authInfo.userId,
    );

    if (authUserInfo == null) {
      throw Exception('User info not found');
    }

    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.email.equals(authUserInfo.email!),
    );

    if (user == null) {
      throw Exception('User not found in database');
    }

    if (!roles.contains(user.role)) {
      throw Exception('User does not have required role');
    }

    return user;
  }
}
