// services/google_auth_service.dart
import 'package:pchaa_client/pchaa_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

late Client client;
late SessionManager sessionManager;
late FlutterAuthenticationKeyManager keyManager;
late GoogleAuthService googleAuthService;

class GoogleAuthService {
  GoogleAuthService(this._googleSignIn);

  final GoogleSignIn _googleSignIn;
  GoogleSignInAccount? _user;

  bool get isLoggedIn => _user != null;
  String? get email => _user?.email;
  String? get name => _user?.displayName;
  String? get photoUrl => _user?.photoUrl;

  // --- Try silent sign-in (restore previous session) ---
  Future<void> restorePreviousSignIn() async {
    _user = await _googleSignIn.signInSilently();
  }

  Future<GoogleSignInAccount?> signIn() async {
    _user = await _googleSignIn.signIn();
    return _user;
  }

  Future<void> signOut() async {
    _user = null;
    await _googleSignIn.signOut();
  }
}