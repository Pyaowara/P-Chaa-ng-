import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/screens/add_menu_page.dart';
import 'package:pchaa_flutter/screens/edit_menu_page.dart';
import 'package:pchaa_flutter/screens/ingredient_management.dart';
import 'package:pchaa_flutter/screens/main_page.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/services/menu_item_service.dart';
import 'package:pchaa_flutter/utils/url_utils.dart';
import 'package:pchaa_flutter/widgets/common/app_button.dart';
import 'package:pchaa_flutter/widgets/google_login_button.dart';

class OwnerMainPage extends StatefulWidget {
  const OwnerMainPage({super.key});

  @override
  State<OwnerMainPage> createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  bool isLoggedIn = googleAuthService.isLoggedIn;
  final MenuItemService _menuItemService = MenuItemService();
  bool _isLoadingMenuItems = true;

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
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
          // Header styled like main_page
          Stack(
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
                      onLoginSuccess: () {
                        _updateLoginStatus();
                      },
                      onLogoutSuccess: () {
                        _updateLoginStatus();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const MainPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
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
                          return _buildMenuItemCard(item);
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

  Widget _buildMenuItemCard(MenuItemWithUrl item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        onTap: () => _navigateToEditMenu(item),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Menu image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: UrlUtils.getDisplayableImageUrl(item.imageUrl).isNotEmpty
                    ? Image.network(
                        UrlUtils.getDisplayableImageUrl(item.imageUrl),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.restaurant_menu,
                          color: Colors.grey,
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              // Menu details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '฿${item.basePrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // Availability status
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: item.isAvailable
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.isAvailable ? 'พร้อมขาย' : 'ไม่พร้อม',
                  style: TextStyle(
                    color: item.isAvailable ? Colors.green : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
