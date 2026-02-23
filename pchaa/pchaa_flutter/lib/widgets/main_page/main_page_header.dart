import 'package:flutter/material.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/widgets/google_login_button.dart';

class MainPageHeader extends StatelessWidget {
  final bool isLoggedIn;
  final VoidCallback onLoginSuccess;
  final VoidCallback onLogoutSuccess;

  const MainPageHeader({
    super.key,
    required this.isLoggedIn,
    required this.onLoginSuccess,
    required this.onLogoutSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background food image (hidden if logged in)
        if (!isLoggedIn)
          Container(
            height: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/food.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

        // Gradient / overlay container
        Container(
          height: isLoggedIn ? 150 : 300,
          decoration: BoxDecoration(
            gradient: isLoggedIn
                ? null
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
            color: Colors.white,
          ),
        ),

        // Positioned welcome text and button
        Positioned(
          bottom: 20,
          left: isLoggedIn ? 30 : 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLoggedIn)
                      const Text(
                        'ยินดีต้อนรับ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      isLoggedIn
                          ? (googleAuthService.name ?? "")
                          : 'ร้านพี่ช้าง',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: isLoggedIn ? Colors.black : Colors.white,
                        fontSize: isLoggedIn ? 20 : 30,
                        fontWeight: isLoggedIn
                            ? FontWeight.normal
                            : FontWeight.bold,
                        shadows: isLoggedIn
                            ? null
                            : [
                                Shadow(
                                  offset: Offset(2, 1),
                                  blurRadius: 10,
                                  color: Colors.grey,
                                ),
                              ],
                      ),
                    ),
                  ],
                ),
              ),
              GoogleLoginButton(
                onLoginSuccess: onLoginSuccess,
                onLogoutSuccess: onLogoutSuccess,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
