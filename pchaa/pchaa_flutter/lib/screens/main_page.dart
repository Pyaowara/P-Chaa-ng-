import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/screens/customer_order_status.dart';
import 'package:pchaa_flutter/screens/owner_main_page.dart';
import 'package:pchaa_flutter/widgets/common/app_button.dart';
import 'package:pchaa_flutter/widgets/main_page/main_page_header.dart';
import 'package:pchaa_flutter/widgets/main_page/store_status_banner.dart';
import 'package:pchaa_flutter/widgets/main_page/queue_section.dart';
import 'package:pchaa_flutter/widgets/main_page/menu_button.dart';
import 'package:pchaa_flutter/widgets/queue/queueready.dart';
import '../services/app_services.dart';

class MainPage extends StatefulWidget {
  final Order? orderToOpen;

  const MainPage({super.key, this.orderToOpen});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoggedIn = googleAuthService.isLoggedIn;
  bool isOpen = isShopOpen;
  List<Order> myOrders = [];
  StoreSettings store = settings;
  bool _didOpenInitialOrder = false;
  Timer? _ordersRefreshTimer;

  @override
  void initState() {
    super.initState();
    _initializePage();
    _startOrdersAutoRefresh();
  }

  @override
  void dispose() {
    _ordersRefreshTimer?.cancel();
    super.dispose();
  }

  void _startOrdersAutoRefresh() {
    _ordersRefreshTimer?.cancel();
    _ordersRefreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (isLoggedIn) {

        _fetchMyOrders();
      }
    });
  }

  Future<void> _initializePage() async {
    await _fetchStoreStatus();
    if (isLoggedIn) {

      await _fetchMyOrders();
    }

    if (!mounted || _didOpenInitialOrder || widget.orderToOpen == null) {
      return;
    }

    _didOpenInitialOrder = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (_) => CustomerOrderStatus(
                orderid: widget.orderToOpen!.id!,
              ),
            ),
          )
          .then((_) => _fetchMyOrders());
    });
  }

  

  Future<void> _fetchMyOrders() async {
    try {
      final orders = await client.order.getMyOrders();
      if (!mounted) return;
      setState(() {
        myOrders = orders.reversed.toList();
      });
    } catch (e) {
      debugPrint('Error fetching orders: $e');
    }
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
    } else {
      _fetchMyOrders();
    }
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
                  _updateLoginStatus();
                },
              ),

              const SizedBox(height: 1),

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
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Queue section
                    QueueSection(
                      isOpen: isOpen,
                      isLoggedIn: isLoggedIn,
                      orders: myOrders,
                      onNavigate: () {
                        _fetchMyOrders();
                      },
                    ),
                    if (isOpen) Expanded(child: SizedBox()),

                    // Menu button
                    MenuButton(onNavigate: _fetchMyOrders)
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
