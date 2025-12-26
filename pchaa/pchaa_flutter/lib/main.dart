import 'package:pchaa_client/pchaa_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/greetings_screen.dart';

late final Client client;
late SessionManager sessionManager;
late final FlutterAuthenticationKeyManager keyManager;
String? googleProfilePictureUrl;
late final GoogleSignIn googleSignIn;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: dotenv.env['GOOGLE_CLIENT_ID']!,
  );

  keyManager = FlutterAuthenticationKeyManager(
    runMode: 'development',
  );

  client = Client(
    dotenv.env['SERVER_URL']!,
    authenticationKeyManager: keyManager,
  )..connectivityMonitor = FlutterConnectivityMonitor();

  sessionManager = SessionManager(
    caller: client.modules.auth,
  );
  await sessionManager.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    sessionManager.addListener(_onSessionChanged);
  }

  @override
  void dispose() {
    sessionManager.removeListener(_onSessionChanged);
    super.dispose();
  }

  void _onSessionChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P-Chaa-ng App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: sessionManager.signedInUser != null
          ? const MyHomePage(title: 'P-Chaa-ng Food Order')
          : const SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Future<void> _handleGoogleSignIn() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      googleProfilePictureUrl = googleUser.photoUrl;

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
        profilePictureUrl: googleProfilePictureUrl,
      );
    } catch (e) {
      debugPrint('Error during Google sign-in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('P-Chaa-ng Food Order'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _handleGoogleSignIn,
          icon: const Icon(Icons.login),
          label: const Text('Sign in with Google'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _userPictureUrl;

  @override
  void initState() {
    super.initState();
    _loadUserPicture();
  }

  Future<void> _loadUserPicture() async {
    try {
      final user = await client.user.getCurrentUser();
      if (mounted && user?.picture != null) {
        setState(() {
          _userPictureUrl = user!.picture;
        });
      }
    } catch (e) {
      debugPrint('Error loading user picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = sessionManager.signedInUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircularUserImage(
              userInfo: userInfo != null && _userPictureUrl != null
                  ? userInfo.copyWith(imageUrl: _userPictureUrl)
                  : userInfo,
              size: 36,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: () async {
              googleProfilePictureUrl = null;
              await googleSignIn.signOut();
              await sessionManager.signOutDevice();
            },
          ),
        ],
      ),
      body: const GreetingsScreen(),
    );
  }
}
