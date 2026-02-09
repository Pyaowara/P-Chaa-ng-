import 'package:flutter/material.dart';
import 'package:pchaa_flutter/screens/main_page.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/widgets/google_login_button.dart';

class OwnerMainPage extends StatefulWidget {
  const OwnerMainPage({super.key});

  @override
  State<OwnerMainPage> createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  bool isLoggedIn = googleAuthService.isLoggedIn;
  void _updateLoginStatus() {
    debugPrint("⚡ _updateLoginStatus called");
    debugPrint(
      "⚡ googleAuthService.isLoggedIn = ${googleAuthService.isLoggedIn}",
    );
    setState(() {
      isLoggedIn = googleAuthService.isLoggedIn;
      debugPrint("⚡ Updated isLoggedIn to: $isLoggedIn");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 160, 160, 160),
            ),
            child: Row(
              children: [
                GoogleLoginButton(
                  onLoginSuccess: () {
                    setState(() {
                      _updateLoginStatus();
                    });
                  },
                  onLogoutSuccess: () {
                    setState(() {
                      _updateLoginStatus();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const MainPage(),
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
