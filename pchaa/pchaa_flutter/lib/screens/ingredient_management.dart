import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/ingredient_services.dart';
import 'package:pchaa_flutter/widgets/ingredient_modal.dart';
import 'package:pchaa_flutter/widgets/ingredient_list.dart';

class IngredientManagementPage extends StatefulWidget {
  const IngredientManagementPage({super.key});

  @override
  State<IngredientManagementPage> createState() =>
      _IngredientManagementPageState();
}

class _IngredientManagementPageState extends State<IngredientManagementPage> {
  late IngredientService ingredientService;
  bool _isLoaded = false;
  String _filterText = '';

  @override
  void initState() {
    super.initState();
    ingredientService = IngredientService();
    _loadIngredients();
  }

  Future<void> _loadIngredients() async {
    try {
      await ingredientService.fetchAllIngredients();
      setState(() {
        _isLoaded = true;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: ${e.toString()}')),
        );
      }
    }
  }

  void _showCreateIngredientModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => IngredientModal(
        ingredientService: ingredientService,
        onSuccess: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('สร้างวัตถุดิบสำเร็จ')),
          );
          _loadIngredients();
        },
      ),
    );
  }

  void _showEditIngredientModal(Ingredient ingredient) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => IngredientModal(
        ingredient: ingredient,
        ingredientService: ingredientService,
        onSuccess: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('อัปเดตวัตถุดิบสำเร็จ')),
          );
          _loadIngredients();
        },
        onDelete: () => _deleteIngredient(
          ingredient.id!,
          onDeleteSuccess: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Future<void> _deleteIngredient(int ingredientId, {VoidCallback? onDeleteSuccess}) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ยืนยันการลบ'),
        content: const Text('คุณต้องการลบวัตถุดิบนี้หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await ingredientService.deleteIngredient(ingredientId);
                if (mounted) {
                  onDeleteSuccess?.call();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ลบวัตถุดิบสำเร็จ')),
                  );
                  _loadIngredients();
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('เกิดข้อผิดพลาด: ${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('ลบ', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  List<Ingredient> _getFilteredIngredients() {
    if (_filterText.isEmpty) {
      return ingredientService.ingredients;
    }
    return ingredientService.ingredients
        .where((ingredient) =>
            ingredient.name.toLowerCase().contains(_filterText.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFececec),
      appBar: AppBar(
        backgroundColor: const Color(0xFFececec),
        elevation: 0,
        title: const Text(
          'จัดการวัตถุดิบ',
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
      body: _isLoaded
          ? Column(
              children: [
                // Filter and Create Button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _filterText = value;
                            });
                          },
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                            hintText: 'ค้นหาวัตถุดิบ...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: _showCreateIngredientModal,
                        icon: const Icon(Icons.add),
                        label: const Text('เพิ่มวัตถุดิบ'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5B8FA3),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // List
                Expanded(
                  child: ListenableBuilder(
                    listenable: ingredientService,
                    builder: (context, child) {
                      if (ingredientService.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final filteredIngredients = _getFilteredIngredients();

                      if (filteredIngredients.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.inventory_2_outlined,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _filterText.isEmpty
                                    ? 'ยังไม่มีวัตถุดิบ'
                                    : 'ไม่พบวัตถุดิบที่ค้นหา',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredIngredients.length,
                        itemBuilder: (context, index) {
                          final ingredient = filteredIngredients[index];
                          return IngredientList(
                            ingredient: ingredient,
                            onEditPressed: () =>
                                _showEditIngredientModal(ingredient),
                            onDeletePressed: () {},
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: null,
    );
  }
}
