import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/cart_service.dart';
import 'package:pchaa_flutter/services/google_auth_service.dart';
import 'package:pchaa_flutter/services/notification_service.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

// Core Serverpod client
late Client client;

// Session management
late SessionManager sessionManager;
late FlutterAuthenticationKeyManager keyManager;
late bool isShopOpen;
late StoreSettings settings;

// App services (declared without import to avoid circular dependency)
// Import GoogleAuthService and CartService where needed
late GoogleAuthService googleAuthService; // Will be GoogleAuthService instance
late CartService cartService; // Will be CartService instance
late NotificationService notificationService; // FCM notification service
