import 'package:flutter/material.dart';
import 'package:pchaa_flutter/screens/add_menu_page.dart';
import 'package:pchaa_flutter/screens/ingredient_management.dart';
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header styled like main_page
          Stack(
            children: [
              // White background container
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
              // Positioned welcome text and login button
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

          const SizedBox(height: 10),

          // Main content area with buttons
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Color(0xFFececec),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'จัดการร้าน',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Add Menu button
                    _buildActionButton(
                      icon: Icons.restaurant_menu,
                      label: 'เพิ่มเมนู',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddMenuPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // Ingredient Management button
                    _buildActionButton(
                      icon: Icons.inventory_2,
                      label: 'จัดการวัตถุดิบ',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const IngredientManagementPage(),
                          ),
                        );
                      },
                    ),

                    const Spacer(),

                    // Switch to Main Page button
                    _buildActionButton(
                      icon: Icons.storefront,
                      label: 'ไปหน้าหลัก',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ),
                        );
                      },
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

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5B8FA3),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
