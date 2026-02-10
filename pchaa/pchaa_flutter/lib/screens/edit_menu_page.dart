import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/services/ingredient_services.dart';
import 'package:pchaa_flutter/services/menu_item_service.dart';
import 'package:pchaa_flutter/utils/url_utils.dart';
import 'package:pchaa_flutter/widgets/add_menu/menu_item_form.dart';

class EditMenuPage extends StatefulWidget {
  final MenuItemWithUrl menuItem;

  const EditMenuPage({super.key, required this.menuItem});

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  final MenuItemService _menuItemService = MenuItemService();
  final IngredientService _ingredientService = IngredientService();
  bool _isLoading = false;
  bool _isDataLoaded = false;
  MenuItemWithUrl? _loadedMenuItem;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Fetch fresh menu item details and ingredients in parallel
      final results = await Future.wait([
        _menuItemService.getMenuItemById(widget.menuItem.id!),
        _ingredientService.fetchAllIngredients(),
      ]);

      setState(() {
        _loadedMenuItem = results[0] as MenuItemWithUrl?;
        _isDataLoaded = true;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _updateMenuItem({
    required String name,
    required double basePrice,
    required int timeToPrepare,
    required List<CustomizationGroup> customization,
    required bool isAvailable,
    required List<int>? ingredientIds,
    required XFile? imageFile,
  }) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _menuItemService.updateMenuItem(
        id: widget.menuItem.id!,
        name: name,
        basePrice: basePrice,
        timeToPrepare: timeToPrepare,
        customization: customization,
        isAvailable: isAvailable,
        ingredientIds: ingredientIds,
        imageFile: imageFile,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('อัปเดตเมนูสำเร็จ'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาด: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _deleteMenuItem() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ยืนยันการลบ'),
        content: Text('คุณต้องการลบเมนู "${widget.menuItem.name}" ใช่หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('ลบ'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _menuItemService.deleteMenuItem(widget.menuItem.id!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ลบเมนูสำเร็จ'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาด: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'แก้ไขเมนู',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _isLoading ? null : _deleteMenuItem,
          ),
        ],
      ),
      body: _isDataLoaded && _loadedMenuItem != null
          ? MenuItemForm(
              existingItem: _loadedMenuItem,
              existingImageUrl: UrlUtils.getDisplayableImageUrl(
                _loadedMenuItem!.imageUrl,
              ),
              availableIngredients: _ingredientService.ingredients,
              isLoading: _isLoading,
              onSubmit:
                  ({
                    required String name,
                    required double basePrice,
                    required int timeToPrepare,
                    required List<CustomizationGroup> customization,
                    required bool isAvailable,
                    required List<int>? ingredientIds,
                    required XFile? imageFile,
                  }) {
                    _updateMenuItem(
                      name: name,
                      basePrice: basePrice,
                      timeToPrepare: timeToPrepare,
                      customization: customization,
                      isAvailable: isAvailable,
                      ingredientIds: ingredientIds,
                      imageFile: imageFile,
                    );
                  },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
