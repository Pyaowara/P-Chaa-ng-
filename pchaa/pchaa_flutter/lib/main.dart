import 'package:pchaa_client/pchaa_client.dart';
import 'package:flutter/material.dart';
import 'package:pchaa_flutter/screens/main_page.dart';
import 'package:pchaa_flutter/screens/owner_main_page.dart';
import 'package:pchaa_flutter/services/cart_service.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './services/app_services.dart';
import './services/google_auth_service.dart';

String? googleProfilePictureUrl;
late final GoogleSignIn googleSignIn;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: dotenv.env['GOOGLE_CLIENT_ID']!,
  );
  googleAuthService = GoogleAuthService(googleSignIn);
  isShopOpen = false;

  // Restore previous login if user had signed in before
  await googleAuthService.restorePreviousSignIn();

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
  if (sessionManager.signedInUser != null) {
    await googleAuthService.fetchUserData();
    debugPrint(await googleAuthService.getToken());
  }
  cartService = CartService();
  if (sessionManager.signedInUser != null) {
    try {
      await cartService.refresh();
    } catch (e) {
      debugPrint('Cart refresh skipped: $e');
    }
  }
  try {
    final storeSettings = await client.store.getStoreSettings();
    isShopOpen = storeSettings.isOpen;
    settings = storeSettings;
  } catch (e) {
    debugPrint('Store settings fetch skipped: $e');
    isShopOpen = false;
    settings = StoreSettings(
      isOpen: false,
      openTime: '07:00:00',
      closeTime: '14:00:00',
      autoOpenClose: false,
    );
  }
  debugPrint(
    "${googleAuthService.userData != null && googleAuthService.userData?.role == UserRole.user}",
  );

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home:
          googleAuthService.userData == null ||
              googleAuthService.userData?.role == UserRole.user
          ? MainPage()
          : OwnerMainPage(),
    );
  }
}
