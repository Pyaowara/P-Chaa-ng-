import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/screens/add_menu_page.dart';
import 'package:pchaa_flutter/screens/edit_menu_page.dart';
import 'package:pchaa_flutter/screens/ingredient_management.dart';
import 'package:pchaa_flutter/services/menu_item_service.dart';
import 'package:pchaa_flutter/widgets/common/app_button.dart';
import 'package:pchaa_flutter/widgets/owner_page/menu_item_card.dart';

class MenuManagementPage extends StatefulWidget {
  const MenuManagementPage({super.key});

  @override
  State<MenuManagementPage> createState() => _MenuManagementPageState();
}

class _MenuManagementPageState extends State<MenuManagementPage> {
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
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'จัดการเมนู',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
              )
            else if (_menuItemService.menuItems.isEmpty)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
                padding: const EdgeInsets.all(20),
                child: const Center(
                  child: Text(
                    'ยังไม่มีเมนู',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
