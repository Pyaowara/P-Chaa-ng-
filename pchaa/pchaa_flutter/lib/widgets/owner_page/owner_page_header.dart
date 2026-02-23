import 'package:flutter/material.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/widgets/google_login_button.dart';

class OwnerPageHeader extends StatelessWidget {
  final VoidCallback onLoginSuccess;
  final VoidCallback onLogoutSuccess;

  const OwnerPageHeader({
    super.key,
    required this.onLoginSuccess,
    required this.onLogoutSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 30,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ยินดีต้อนรับ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      googleAuthService.name ?? "เจ้าของร้าน",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
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
