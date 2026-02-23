import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/screens/owner_main_page.dart';
import 'package:pchaa_flutter/widgets/common/app_button.dart';
import 'package:pchaa_flutter/widgets/main_page/main_page_header.dart';
import 'package:pchaa_flutter/widgets/main_page/store_status_banner.dart';
import 'package:pchaa_flutter/widgets/main_page/queue_section.dart';
import 'package:pchaa_flutter/widgets/main_page/menu_button.dart';
import 'package:pchaa_flutter/widgets/queueready.dart';
import '../services/app_services.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoggedIn = googleAuthService.isLoggedIn;
  bool isOpen = isShopOpen;
  StoreSettings store = settings;

  @override
  void initState() {
    super.initState();
    _fetchStoreStatus();
  }

  Future<void> _fetchStoreStatus() async {
    try {
      final storeSettings = await client.store.getStoreSettings();
      if (mounted) {
        setState(() {
          isOpen = storeSettings.isOpen;
          isShopOpen = storeSettings.isOpen;
          store = storeSettings;
        });
      }
    } catch (e) {
      debugPrint('Failed to fetch store status: $e');
    }
  }

  void _updateLoginStatus() {
    debugPrint("⚡ _updateLoginStatus called");
    setState(() {
      isLoggedIn = googleAuthService.isLoggedIn;
    });
  }

  void _handleLoginSuccess() {
    _updateLoginStatus();
    if (googleAuthService.userData?.role == UserRole.owner && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OwnerMainPage()),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header section
          Column(
            children: [
              MainPageHeader(
                isLoggedIn: isLoggedIn,
                onLoginSuccess: _handleLoginSuccess,
                onLogoutSuccess: () {
                  setState(() {
                    _updateLoginStatus();
                  });
                },
              ),

              const SizedBox(height: 5),

              // Store status banner
              StoreStatusBanner(isOpen: isOpen),

              // Owner admin button
              if (isLoggedIn &&
                  googleAuthService.userData?.role == UserRole.owner)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: AppButton(
                    icon: Icons.admin_panel_settings,
                    label: 'จัดการร้าน',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OwnerMainPage(),
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 10),
            ],
          ),

          // Queue ready section (for logged-in non-owner users)
          if (isLoggedIn &&
              isOpen &&
              googleAuthService.userData?.role != UserRole.owner)
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 15,
              ),
              child: Queueready(),
            ),

          // Bottom content area
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.extraLarge),
                  topRight: Radius.circular(AppRadius.extraLarge),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Queue section
                    QueueSection(isOpen: isOpen, isLoggedIn: isLoggedIn),
                    if (isOpen) Expanded(child: SizedBox()),

                    // Menu button
                    const MenuButton(),
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
