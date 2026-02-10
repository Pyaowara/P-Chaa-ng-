import 'package:flutter/material.dart';

/// Centralized app color constants
class AppColors {
  AppColors._();

  /// Primary brand color - teal/blue accent
  static const Color primary = Color(0xFF5B8FA3);

  /// Background color - light gray
  static const Color background = Color(0xFFececec);

  /// Error/closed state color - red
  static const Color error = Color(0xFFC10007);

  /// Success/open state color - green variant of primary
  static const Color success = Color.fromARGB(195, 87, 156, 181);
}

/// Centralized border radius constants
class AppRadius {
  AppRadius._();

  static const double small = 4.0;
  static const double medium = 12.0;
  static const double large = 20.0;
  static const double extraLarge = 30.0;
}

/// Centralized text styles
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle buttonLabel = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle welcomeTitle = TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle welcomeSubtitle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
}
