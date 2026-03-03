import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pchaa_client/pchaa_client.dart';
import '../services/app_services.dart';
import '../services/cart_service.dart';

class GoogleLoginButton extends StatefulWidget {
  final Function()? onLoginSuccess;
  final Function()? onLogoutSuccess;

  const GoogleLoginButton({
    super.key,
    this.onLoginSuccess,
    this.onLogoutSuccess,
  });

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  bool _loading = false;

  Future<void> _handleLogin() async {
    setState(() => _loading = true);

    try {
      final googleUser = await googleAuthService.signIn();
      if (googleUser == null) return;

      final serverAuthCode = googleUser.serverAuthCode;
      if (serverAuthCode == null) return;

      final authResponse = await client.modules.auth.google
          .authenticateWithServerAuthCode(
            serverAuthCode,
            'http://localhost:8082/googlesignin',
          );

      if (!authResponse.success ||
          authResponse.keyId == null ||
          authResponse.key == null) {
        return;
      }

      await keyManager.put('${authResponse.keyId}:${authResponse.key}');
      await sessionManager.refreshSession();

      await client.user.registerUser(
        profilePictureUrl: googleAuthService.photoUrl,
      );

      await googleAuthService.fetchUserData();

      // Register FCM token and send login notification
      await notificationService.registerTokenWithServer();
      try {
        await client.notification.sendLoginNotification();
      } catch (e) {
        debugPrint('Login notification failed: $e');
      }

      cartService = CartService();
      if (googleAuthService.userData?.role == UserRole.user) {
        await cartService.refresh();
      }

      widget.onLoginSuccess?.call();
      setState(() {});
    } catch (e) {
      debugPrint('Error during Google login: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _handleLogout() async {
    setState(() => _loading = true);
    try {
      // Remove FCM token before signing out
      await notificationService.removeTokenFromServer();
      await googleAuthService.signOut();
      await sessionManager.signOutDevice();
      widget.onLogoutSuccess?.call();
      setState(() {});
    } catch (e) {
      debugPrint('Error during logout: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const CircularProgressIndicator();

    // --- Not logged in: show Login button ---
    if (!googleAuthService.isLoggedIn) {
      return ElevatedButton.icon(
        onPressed: _handleLogin,
        icon: FaIcon(
          FontAwesomeIcons.google,
          size: 20,
        ),
        label: Text(googleAuthService.isLoggedIn ? 'YAY' : '  Login'),

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.withValues(
            alpha: 0.6,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          foregroundColor: Colors.white,
        ),
      );
    }

    final avatar = CircleAvatar(
      backgroundImage: NetworkImage(googleAuthService.photoUrl ?? ''),
      radius: 40,
    );

    return PopupMenuButton<String>(
      offset: Offset(0, 50),
      onSelected: (value) {
        if (value == 'logout') _handleLogout();
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'logout',
          child: Text('Logout'),
        ),
      ],
      child: avatar,
    );
  }
}
