import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/google_auth_service.dart';

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
    print('🚀🚀🚀 _handleLogin STARTED');
    setState(() => _loading = true);

    try {
      print('🔐 Attempting Google sign-in...');
      final googleUser = await googleAuthService.signIn();
      print('📧 Google user result: ${googleUser?.email ?? "NULL"}');
      if (googleUser == null) {
        print('❌ Google user is null, returning early');
        return;
      }

      final serverAuthCode = googleUser.serverAuthCode;
      print('🔑 Server auth code: ${serverAuthCode == null ? "NULL" : "EXISTS"}');
      if (serverAuthCode == null) {
        print('❌ Server auth code is null, returning early');
        return;
      }

      print('🌐 Authenticating with server...');
      final authResponse = await client.modules.auth.google
          .authenticateWithServerAuthCode(
            serverAuthCode,
            'http://localhost:8082/googlesignin',
          );

      print('📝 Auth response - success: ${authResponse.success}, keyId: ${authResponse.keyId}, key: ${authResponse.key != null ? "EXISTS" : "NULL"}');
      if (!authResponse.success ||
          authResponse.keyId == null ||
          authResponse.key == null) {
        print('❌ Auth response failed or missing data, returning early');
        return;
      }

      print('💾 Storing authentication key...');
      await keyManager.put('${authResponse.keyId}:${authResponse.key}');
      print('🔄 Refreshing session...');
      await sessionManager.refreshSession();

      print('👤 Registering user...');
      await client.user.registerUser(
        profilePictureUrl: googleAuthService.photoUrl,
      );
      
      print('✅✅✅ Login successful - About to call onLoginSuccess');
      print('Callback is null? ${widget.onLoginSuccess == null}');
      // Call the callback function if provided
      widget.onLoginSuccess?.call();
      print('✅✅✅ onLoginSuccess callback executed');
      
      setState(() {}); // Refresh UI
    } catch (e) {
      debugPrint('Error during Google login: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _handleLogout() async {
    print('🚪🚪🚪 _handleLogout STARTED');
    setState(() => _loading = true);
    try {
      print('👋 Signing out...');
      await googleAuthService.signOut();
      await sessionManager.signOutDevice();
      
      // Call the callback function if provided
      print("🚪🚪🚪 Logout successful - About to call onLogoutSuccess");
      print('Logout callback is null? ${widget.onLogoutSuccess == null}');
      widget.onLogoutSuccess?.call();
      print("🚪🚪🚪 onLogoutSuccess callback executed");
      
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

    // --- Logged in: show profile picture with dropdown ---
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
