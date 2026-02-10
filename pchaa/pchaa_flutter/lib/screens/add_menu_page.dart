import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/ingredient_services.dart';
import 'package:pchaa_flutter/services/menu_item_service.dart';
import 'package:pchaa_flutter/widgets/add_menu/menu_item_form.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final MenuItemService _menuItemService = MenuItemService();
  final IngredientService _ingredientService = IngredientService();
  bool _isLoading = false;
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await _ingredientService.fetchAllIngredients();
      setState(() {
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

  Future<void> _createMenuItem({
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
      await _menuItemService.createMenuItem(
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
            content: Text('สร้างเมนูสำเร็จ'),
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
      backgroundColor: const Color(0xFFececec),
      appBar: AppBar(
        backgroundColor: const Color(0xFFececec),
        elevation: 0,
        title: const Text(
          'เพิ่มเมนูใหม่',
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
      ),
      body: _isDataLoaded
          ? MenuItemForm(
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
                    _createMenuItem(
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
