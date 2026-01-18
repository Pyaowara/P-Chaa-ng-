import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/screens/available_menu_items_screen.dart';
import 'package:pchaa_flutter/screens/menu_items_screen.dart';
import 'package:pchaa_flutter/screens/menu_screen.dart';
import 'package:pchaa_flutter/widgets/myqueue.dart';
import 'package:pchaa_flutter/widgets/queueready.dart';
import '../services/app_services.dart';
import '../widgets/google_login_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoggedIn = googleAuthService.isLoggedIn;
  bool isOpen = isShopOpen;

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
      body: Column(
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
      
              const SizedBox(height: 5),
              if (isLoggedIn)
                InkWell(
                  onTap: () {
                    setState(() {
                      isShopOpen = !isShopOpen;
                      isOpen = !isOpen;
                    });
                  },
                  child: Container(
                    
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.all(12),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: const Color(0xFFececec),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isOpen ? "ร้านเปิด" : "ร้านปิด",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  width: double.maxFinite,
                  height: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isOpen
                        ? Color.fromARGB(195, 87, 156, 181)
                        : Color(0xFFC10007),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 20,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 7,
                        child: Text(
                          isOpen ? "Opened" : "Closed",
                          style: const TextStyle(
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
                          isOpen ? "ร้านเปิด" : "ร้านปิด",
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
              const SizedBox(height: 20),
            ],
          ),
          if (isLoggedIn && isOpen)
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 15,
              ),
              child: Queueready(),
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
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (isOpen
                        ? (isLoggedIn ? Myqueue(limit: 3, queueList: [Order(userId: 1, status: OrderStatus.preparing, type: OrderType.I, totalOrderPrice: 30, orderDate: DateTime.now(),queueNumber: "I001"),Order(userId: 1, status: OrderStatus.preparing, type: OrderType.I, totalOrderPrice: 30, orderDate: DateTime.now(),queueNumber: "I001"),Order(userId: 1, status: OrderStatus.preparing, type: OrderType.I, totalOrderPrice: 30, orderDate: DateTime.now(),queueNumber: "I001"),Order(userId: 1, status: OrderStatus.preparing, type: OrderType.I, totalOrderPrice: 30, orderDate: DateTime.now(),queueNumber: "I001")],) : Queueready())
                        : Expanded(
                            child: Center(
                              child: Text(
                                'Queue Not\nAvailable',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )),
                    if (isOpen) Expanded(child: SizedBox()),
                    // Menu button
                    Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.all(20),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MenuScreen(),
                            ),
                          );
                        },
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
          ),
        ],
      ),
    );
  }
}
