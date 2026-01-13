import 'package:flutter/material.dart';
import '../services/google_auth_service.dart';
import '../widgets/google_login_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoggedIn = googleAuthService.isLoggedIn;

  @override
  void initState() {
    super.initState();
    // Listen for login status changes
    // googleAuthService.addListener(_updateLoginStatus);
  }

  void _updateLoginStatus() {
    print("⚡ _updateLoginStatus called");
    print("⚡ googleAuthService.isLoggedIn = ${googleAuthService.isLoggedIn}");
    setState(() {
      isLoggedIn = googleAuthService.isLoggedIn;
      print("⚡ Updated isLoggedIn to: $isLoggedIn");
    });
  }

  @override
  void dispose() {
    // googleAuthService.removeListener(_updateLoginStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              color: Colors.green,
            ),
          ),
          Column(
            children: [
              Column(
                children: [
                  // Header with food image and restaurant info
                  Stack(
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
                                      color: isLoggedIn
                                          ? Colors.black
                                          : Colors.white,
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
                              onLoginSuccess: () {
                                setState(() {
                                  _updateLoginStatus();
                                });
                              },
                              onLogoutSuccess: () {
                                setState(() {
                                  _updateLoginStatus();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  Container(
                    width: double.maxFinite,
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC10007),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Stack(
                      children: const [
                        Positioned(
                          left: 10,
                          top: 7,
                          child: Text(
                            "Closed",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 1,
                          child: Text(
                            "ร้านปิด",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),

              // Queue status and Menu button with green background
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: const Color(0xFFececec),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Queued Not\nAvailable',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      // Menu button
                      Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.all(20),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.menu),
                          label: const Text(
                            'MENU เมนูอาหาร',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5B8FA3),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
