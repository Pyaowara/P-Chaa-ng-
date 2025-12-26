import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import '../generated/protocol.dart';

class UserEndpoint extends Endpoint {
  Future<User?> registerUser(
    Session session, {
    String? profilePictureUrl,
  }) async {
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

    if (authInfo == null) {
      return null;
    }

    final authUserInfo = await auth.Users.findUserByUserId(
      session,
      authInfo.userId,
    );

    if (authUserInfo == null) {
      return null;
    }

    return await User.db.findFirstRow(
      session,
      where: (t) => t.email.equals(authUserInfo.email!),
    );
  }
}
