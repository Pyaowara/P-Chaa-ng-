// services/google_auth_service.dart
import 'package:flutter/cupertino.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pchaa_flutter/services/app_services.dart';

class GoogleAuthService {
  GoogleAuthService(this._googleSignIn);

  final GoogleSignIn _googleSignIn;
  GoogleSignInAccount? _user;
  User? _userData;

  bool get isLoggedIn => _user != null;
  String? get email => _user?.email;
  String? get name => _user?.displayName;
  String? get photoUrl => _user?.photoUrl;
  User? get userData => _userData;

  /// Get the current authentication token
  /// Returns Serverpod auth key or Google access token
  
  Future<String?> getToken() async {
    // Try Serverpod auth key first
    try {
      final key = await keyManager.get();
      if (key != null) {
        return key;
      }
    } catch (e) {
      debugPrint('Failed to get Serverpod token: $e');
    }

    // Fallback to Google access token
    try {
      if (_user != null) {
        final auth = await _user!.authentication;
        return auth.accessToken;
      }
    } catch (e) {
      debugPrint('Failed to get Google access token: $e');
    }

    return null;
  }

  Future<void> restorePreviousSignIn() async {
    _user = await _googleSignIn.signInSilently();
    // Initialize cart service if user was previously logged in
    // if (_user != null) {
    //   try {
    //     cartService = CartService();
    //     await cartService.refresh();
    //     debugPrint('Cart service restored for returning user');
    //   } catch (e) {
    //     debugPrint('Failed to restore cart service: $e');
    //   }
    // }
  }

  Future<GoogleSignInAccount?> signIn() async {
    _user = await _googleSignIn.signIn();
    debugPrint(_user.toString());
    return _user;
  }

  /// Fetch and store user data from server
  /// Call this AFTER session is authenticated
  Future<void> fetchUserData() async {
    try {
      _userData = await client.user.getCurrentUser();
      debugPrint('User data fetched: $_userData');
    } catch (e) {
      debugPrint('Failed to fetch user data: $e');
    }
  }

  Future<void> signOut() async {
    _user = null;
    _userData = null;
    await _googleSignIn.signOut();
  }
}