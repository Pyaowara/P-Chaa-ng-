import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import '../generated/protocol.dart';
import '../utils/auth_utils.dart';

class UserEndpoint extends Endpoint {
  Future<User?> registerUser(
    Session session, {
    String? profilePictureUrl,
  }) async {
    await AuthUtils.isAuthenticated(session);

    final authInfo = await session.authenticated;
    final authUserInfo = await auth.Users.findUserByUserId(
      session,
      authInfo!.userId,
    );

    if (authUserInfo == null) {
      throw Exception('User info not found');
    }

    final existingUser = await User.db.findFirstRow(
      session,
      where: (t) => t.email.equals(authUserInfo.email!),
    );

    if (existingUser != null) {
      if (profilePictureUrl != null &&
          existingUser.picture != profilePictureUrl) {
        final updatedUser = existingUser.copyWith(
          picture: profilePictureUrl,
          fullName: authUserInfo.fullName ?? existingUser.fullName,
        );

        final result = await User.db.updateRow(session, updatedUser);
        session.log(
          '[UserEndpoint] Updated user profile picture: ${authUserInfo.email}',
        );
        return result;
      }

      session.log('[UserEndpoint] User already exists: ${authUserInfo.email}');
      return existingUser;
    }

    final newUser = User(
      email: authUserInfo.email!,
      fullName: authUserInfo.fullName ?? authUserInfo.email!,
      picture: profilePictureUrl,
      phoneNumber: null,
      role: UserRole.user,
      createdAt: DateTime.now(),
    );

    final insertedUser = await User.db.insertRow(
      session,
      newUser,
    );

    session.log(
      '[UserEndpoint] Created new user: ${authUserInfo.email} with role: user',
    );

    return insertedUser;
  }

  Future<User?> getCurrentUser(Session session) async {
    final authInfo = await session.authenticated;
    print(session.authenticationKey);

    if (authInfo == null) {
      session.log(
        '[UserEndpoint] No authentication info found - token may be invalid or missing',
      );
      return null;
    }

    session.log('[UserEndpoint] Authenticated userId: ${authInfo.userId}');

    final authUserInfo = await auth.Users.findUserByUserId(
      session,
      authInfo.userId,
    );

    if (authUserInfo == null) {
      session.log(
        '[UserEndpoint] No auth user info found for userId: ${authInfo.userId}',
      );
      return null;
    }

    session.log('[UserEndpoint] Found auth user: ${authUserInfo.email}');

    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.email.equals(authUserInfo.email!),
    );

    if (user == null) {
      session.log(
        '[UserEndpoint] User not found in database for email: ${authUserInfo.email}',
      );
    } else {
      session.log('[UserEndpoint] Found user: ${user.email}');
    }

    return user;
  }

  Future<List<User>?> getAllUser(Session session) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);

    return await User.db.find(session);
  }

  Future<User> updateUserRole(
    Session session,
    int userId,
    UserRole newRole,
  ) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);

    final targetUser = await User.db.findById(session, userId);

    if (targetUser == null) {
      throw Exception('Target user not found');
    }

    final updatedUser = targetUser.copyWith(role: newRole);
    final result = await User.db.updateRow(session, updatedUser);

    session.log(
      '[UserEndpoint] Updated role of user ${targetUser.email} to ${newRole.name}',
    );

    return result;
  }
}
