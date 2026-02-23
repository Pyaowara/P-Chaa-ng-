import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/screens/add_menu_page.dart';
import 'package:pchaa_flutter/screens/edit_menu_page.dart';
import 'package:pchaa_flutter/screens/ingredient_management.dart';
import 'package:pchaa_flutter/screens/main_page.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/services/menu_item_service.dart';
import 'package:pchaa_flutter/widgets/common/app_button.dart';
import 'package:pchaa_flutter/widgets/owner_page/owner_page_header.dart';
import 'package:pchaa_flutter/widgets/owner_page/store_toggle.dart';
import 'package:pchaa_flutter/widgets/owner_page/store_time_pickers.dart';
import 'package:pchaa_flutter/widgets/owner_page/menu_item_card.dart';

class OwnerMainPage extends StatefulWidget {
  const OwnerMainPage({super.key});

  @override
  State<OwnerMainPage> createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  bool isLoggedIn = googleAuthService.isLoggedIn;
  final MenuItemService _menuItemService = MenuItemService();
  bool _isLoadingMenuItems = true;
  bool _isOpen = isShopOpen;
  bool _isTogglingStore = false;
  TimeOfDay _openTime = _parseTime(settings.openTime);
  TimeOfDay _closeTime = _parseTime(settings.closeTime);

  static TimeOfDay _parseTime(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static String _formatTime(TimeOfDay t) {
    return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:00';
  }

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
    _fetchStoreStatus();
  }

  Future<void> _fetchStoreStatus() async {
    try {
      final storeSettings = await client.store.getStoreSettings();
      if (mounted) {
        setState(() {
          _isOpen = storeSettings.isOpen;
          isShopOpen = storeSettings.isOpen;
          _openTime = _parseTime(storeSettings.openTime);
          _closeTime = _parseTime(storeSettings.closeTime);
        });
      }
    } catch (e) {
      debugPrint('Failed to fetch store status: $e');
    }
  }

  Future<void> _pickTime({required bool isOpenTime}) async {
    final initial = isOpenTime ? _openTime : _closeTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked == null || !mounted) return;

    setState(() {
      if (isOpenTime) {
        _openTime = picked;
      } else {
        _closeTime = picked;
      }
    });

    try {
      await client.store.updateStoreSettings(
        StoreSettings(
          isOpen: _isOpen,
          openTime: _formatTime(_openTime),
          closeTime: _formatTime(_closeTime),
          autoOpenClose: settings.autoOpenClose,
        ),
      );
      settings = settings.copyWith(
        openTime: _formatTime(_openTime),
        closeTime: _formatTime(_closeTime),
      );
    } catch (e) {
      debugPrint('Failed to update store times: $e');
    }
  }

  Future<void> _toggleStoreStatus() async {
    setState(() {
      _isTogglingStore = true;
    });
    try {
      final newStatus = !_isOpen;
      await client.store.updateStoreStatus(newStatus);
      setState(() {
        _isOpen = newStatus;
        isShopOpen = newStatus;
      });
    } catch (e) {
      debugPrint('Failed to toggle store status: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isTogglingStore = false;
        });
      }
    }
  }

  Future<void> _loadMenuItems() async {
    setState(() {
      _isLoadingMenuItems = true;
    });
    try {
      await _menuItemService.fetchAllMenuItems();
    } catch (e) {
      debugPrint('Error loading menu items: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMenuItems = false;
        });
      }
    }
  }

  void _updateLoginStatus() {
    setState(() {
      isLoggedIn = googleAuthService.isLoggedIn;
    });
  }

  Future<void> _navigateToEditMenu(MenuItemWithUrl menuItem) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMenuPage(menuItem: menuItem),
      ),
    );
    if (result == true) {
      _loadMenuItems();
    }
  }

  Future<void> _navigateToAddMenu() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddMenuPage(),
      ),
    );
    if (result == true) {
      _loadMenuItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          OwnerPageHeader(
            onLoginSuccess: _updateLoginStatus,
            onLogoutSuccess: () {
              _updateLoginStatus();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const MainPage()),
              );
            },
          ),

          // Store toggle
          StoreToggle(
            isOpen: _isOpen,
            isToggling: _isTogglingStore,
            onToggle: _toggleStoreStatus,
          ),

          // Time pickers
          StoreTimePickers(
            openTime: _openTime,
            closeTime: _closeTime,
            onPickOpenTime: () => _pickTime(isOpenTime: true),
            onPickCloseTime: () => _pickTime(isOpenTime: false),
          ),

          const SizedBox(height: 10),

          // Main content area
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.extraLarge),
                  topRight: Radius.circular(AppRadius.extraLarge),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'จัดการร้าน',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 16),

                    // Add Menu button
                    AppButton(
                      icon: Icons.restaurant_menu,
                      label: 'เพิ่มเมนู',
                      onPressed: _navigateToAddMenu,
                    ),
                    const SizedBox(height: 12),

                    // Ingredient Management button
                    AppButton(
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
                    const SizedBox(height: 24),

                    // Menu items section
                    const Text(
                      'รายการเมนูทั้งหมด',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 12),

                    if (_isLoadingMenuItems)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (_menuItemService.menuItems.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'ยังไม่มีเมนู',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _menuItemService.menuItems.length,
                        itemBuilder: (context, index) {
                          final item = _menuItemService.menuItems[index];
                          return MenuItemCard(
                            item: item,
                            onTap: () => _navigateToEditMenu(item),
                          );
                        },
                      ),

                    const SizedBox(height: 24),

                    // Switch to Main Page button
                    AppButton(
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
                    const SizedBox(height: 20),
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
