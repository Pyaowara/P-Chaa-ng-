import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/widgets/add_menu/customization_group_editor.dart';
import 'package:pchaa_flutter/widgets/add_menu/image_picker_field.dart';

/// Main form widget for adding/editing menu items
class MenuItemForm extends StatefulWidget {
  final MenuItemWithUrl? existingItem;
  final String? existingImageUrl;
  final List<Ingredient> availableIngredients;
  final Function({
    required String name,
    required double basePrice,
    required int timeToPrepare,
    required List<CustomizationGroup> customization,
    required bool isAvailable,
    required List<int>? ingredientIds,
    required XFile? imageFile,
  })
  onSubmit;
  final bool isLoading;

  const MenuItemForm({
    super.key,
    this.existingItem,
    this.existingImageUrl,
    required this.availableIngredients,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<MenuItemForm> createState() => _MenuItemFormState();
}

class _MenuItemFormState extends State<MenuItemForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _timeController;
  late bool _isAvailable;
  late List<int> _selectedIngredientIds;
  late List<CustomizationGroup> _customizationGroups;
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    final item = widget.existingItem;
    _nameController = TextEditingController(text: item?.name ?? '');
    _priceController = TextEditingController(
      text: item?.basePrice.toString() ?? '',
    );
    _timeController = TextEditingController(
      text: item?.timeToPrepare.toString() ?? '15',
    );
    _isAvailable = item?.isAvailable ?? true;
    _selectedIngredientIds = List.from(item?.ingredientIds ?? []);
    _customizationGroups = List.from(item?.customization ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _addCustomizationGroup() {
    setState(() {
      _customizationGroups.add(
        CustomizationGroup(
          title: '',
          pickOne: true,
          choices: [],
        ),
      );
    });
  }

  void _updateCustomizationGroup(int index, CustomizationGroup group) {
    setState(() {
      _customizationGroups[index] = group;
    });
  }

  void _deleteCustomizationGroup(int index) {
    setState(() {
      _customizationGroups.removeAt(index);
    });
  }

  void _showIngredientSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'เลือกวัตถุดิบหลัก',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('เสร็จสิ้น'),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.availableIngredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = widget.availableIngredients[index];
                    final isSelected = _selectedIngredientIds.contains(
                      ingredient.id,
                    );
                    return CheckboxListTile(
                      title: Text(ingredient.name),
                      subtitle: Text(
                        ingredient.isAvailable
                            ? 'พร้อมใช้งาน'
                            : 'ไม่พร้อมใช้งาน',
                        style: TextStyle(
                          color: ingredient.isAvailable
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      value: isSelected,
                      onChanged: (value) {
                        setModalState(() {
                          setState(() {
                            if (value == true) {
                              _selectedIngredientIds.add(ingredient.id!);
                            } else {
                              _selectedIngredientIds.remove(ingredient.id);
                            }
                          });
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        name: _nameController.text.trim(),
        basePrice: double.tryParse(_priceController.text) ?? 0,
        timeToPrepare: int.tryParse(_timeController.text) ?? 0,
        customization: _customizationGroups,
        isAvailable: _isAvailable,
        ingredientIds: _selectedIngredientIds.isEmpty
            ? null
            : _selectedIngredientIds,
        imageFile: _selectedImage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image picker
            ImagePickerField(
              initialImageUrl: widget.existingImageUrl,
              onImageSelected: (image) {
                setState(() {
                  _selectedImage = image;
                });
              },
            ),
            const SizedBox(height: 20),

            // Menu name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'ชื่อเมนู *',
                hintText: 'เช่น ข้าวผัดกระเพรา',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'กรุณากรอกชื่อเมนู';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Price and time row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'ราคา (บาท) *',
                      hintText: '0.00',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'กรุณากรอกราคา';
                      }
                      if (double.tryParse(value) == null) {
                        return 'ราคาไม่ถูกต้อง';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                      labelText: 'เวลาทำ (นาที) *',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'กรุณากรอกเวลา';
                      }
                      if (int.tryParse(value) == null) {
                        return 'เวลาไม่ถูกต้อง';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Availability toggle
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'พร้อมขาย',
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    value: _isAvailable,
                    onChanged: (value) {
                      setState(() {
                        _isAvailable = value;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Ingredient selector
            InkWell(
              onTap: _showIngredientSelector,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.inventory_2_outlined),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'วัตถุดิบหลัก',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            _selectedIngredientIds.isEmpty
                                ? 'แตะเพื่อเลือกวัตถุดิบ'
                                : '${_selectedIngredientIds.length} วัตถุดิบ',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Customization groups
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'กลุ่มตัวเลือกเสริม',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: _addCustomizationGroup,
                  icon: const Icon(Icons.add),
                  label: const Text('เพิ่มกลุ่ม'),
                ),
              ],
            ),
            ..._customizationGroups.asMap().entries.map((entry) {
              final index = entry.key;
              final group = entry.value;
              return CustomizationGroupEditor(
                key: ValueKey('group_$index'),
                group: group,
                availableIngredients: widget.availableIngredients,
                onChanged: (updated) =>
                    _updateCustomizationGroup(index, updated),
                onDelete: () => _deleteCustomizationGroup(index),
              );
            }),
            const SizedBox(height: 32),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                  ),
                ),
                child: widget.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        widget.existingItem != null
                            ? 'อัปเดตเมนู'
                            : 'สร้างเมนู',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
