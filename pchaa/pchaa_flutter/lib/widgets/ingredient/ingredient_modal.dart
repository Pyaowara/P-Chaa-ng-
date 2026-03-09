import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/ingredient_services.dart';

class IngredientModal extends StatefulWidget {
  final IngredientService ingredientService;
  final VoidCallback onSuccess;
  final Ingredient? ingredient;
  final VoidCallback? onDelete;

  const IngredientModal({
    super.key,
    required this.ingredientService,
    required this.onSuccess,
    this.ingredient,
    this.onDelete,
  });

  @override
  State<IngredientModal> createState() => _IngredientModalState();
}

class _IngredientModalState extends State<IngredientModal> {
  late TextEditingController _nameController;
  late bool _isAvailable;
  bool _isLoading = false;

  bool get _isEdit => widget.ingredient != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.ingredient?.name ?? '');
    _isAvailable = widget.ingredient?.isAvailable ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_nameController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('กรุณากรอกชื่อวัตถุดิบ'),
          content: const Text('ต้องกรอกชื่อวัตถุดิบก่อนทำการสร้าง'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ยืนยัน'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (_isEdit) {
        final ingredientId = widget.ingredient?.id;
        if (ingredientId == null) {
          throw Exception('ไม่พบรหัสวัตถุดิบ');
        }
        await widget.ingredientService.updateIngredient(
          id: ingredientId,
          name: _nameController.text,
          isAvailable: _isAvailable,
        );
      } else {
        await widget.ingredientService.createIngredient(
          name: _nameController.text,
          isAvailable: _isAvailable,
        );
      }
      if (mounted) {
        widget.onSuccess();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleText = _isEdit ? 'แก้ไขวัตถุดิบ' : 'เพิ่มวัตถุดิบใหม่';
    final submitText = _isEdit ? 'บันทึก' : 'สร้าง';

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _isEdit
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        titleText,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: _isLoading ? null : widget.onDelete,
                        tooltip: 'ลบวัตถุดิบ',
                      ),
                    ],
                  )
                : Text(
                    titleText,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                hintText: 'ชื่อวัตถุดิบ',
                labelText: 'ชื่อวัตถุดิบ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.inventory_2),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'สถานะวัตถุดิบ:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(
                        value: true,
                        label: Text('มี'),
                        icon: Icon(Icons.check_circle),
                      ),
                      ButtonSegment(
                        value: false,
                        label: Text('หมด'),
                        icon: Icon(Icons.cancel),
                      ),
                    ],
                    selected: {_isAvailable},
                    onSelectionChanged: (Set<bool> newSelection) {
                      setState(() {
                        _isAvailable = newSelection.first;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('ยกเลิก'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B8FA3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(submitText),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
