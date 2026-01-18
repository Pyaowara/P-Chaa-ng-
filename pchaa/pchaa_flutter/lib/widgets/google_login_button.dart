import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    debugPrint('_handleLogin STARTED');
    setState(() => _loading = true);

    try {
      debugPrint('Attempting Google sign-in...');
      final googleUser = await googleAuthService.signIn();
      debugPrint('Google user result: ${googleUser?.email ?? "NULL"}');
      if (googleUser == null) {
        debugPrint('Google user is null');
        return;
      }

      final serverAuthCode = googleUser.serverAuthCode;
      debugPrint('🔑 Server auth code: ${serverAuthCode == null ? "NULL" : "EXISTS"}');
      if (serverAuthCode == null) {
        debugPrint('Server auth code is null');
        return;
      }

      debugPrint('🌐 Authenticating with server...');
      final authResponse = await client.modules.auth.google
          .authenticateWithServerAuthCode(
            serverAuthCode,
            'http://localhost:8082/googlesignin',
          );

      debugPrint('Auth response - success: ${authResponse.success}, keyId: ${authResponse.keyId}, key: ${authResponse.key != null ? "EXISTS" : "NULL"}');
      if (!authResponse.success ||
          authResponse.keyId == null ||
          authResponse.key == null) {
        debugPrint('Auth response failed or missing data, returning early');
        return;
      }

      debugPrint('Storing authentication key...');
      debugPrint('${authResponse.keyId}:${authResponse.key}');
      await keyManager.put('${authResponse.keyId}:${authResponse.key}');
      debugPrint('Refreshing session...');
      await sessionManager.refreshSession();

      debugPrint('Registering user...');
      await client.user.registerUser(
        profilePictureUrl: googleAuthService.photoUrl,
      );
      
      debugPrint('Fetching user data...');
      await googleAuthService.fetchUserData();
      debugPrint((await client.user.getCurrentUser()).toString());
      
      debugPrint('Initializing cart service...');
      cartService = CartService();
      await cartService.refresh();
      
      debugPrint('Login successful - calling onLoginSuccess');
      debugPrint('Callback is null? ${widget.onLoginSuccess == null}');
      // Call the callback function if provided
      widget.onLoginSuccess?.call();
      debugPrint('onLoginSuccess callback executed');
      debugPrint(await googleAuthService.getToken());
      setState(() {}); // Refresh UI
    } catch (e) {
      debugPrint('Error during Google login: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _handleLogout() async {
    debugPrint('_handleLogout STARTED');
    setState(() => _loading = true);
    try {
      debugPrint('👋 Signing out...');
      await googleAuthService.signOut();
      await sessionManager.signOutDevice();
      
      debugPrint("Logout successful - calling onLogoutSuccess");
      debugPrint('Logout callback is null? ${widget.onLogoutSuccess == null}');
      widget.onLogoutSuccess?.call();
      debugPrint("onLogoutSuccess callback executed");
      
      setState(() {}); // Refresh UI
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
