import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';

/// Widget for editing a single AddOnOption
class AddOnOptionEditor extends StatefulWidget {
  final AddOnOption option;
  final List<Ingredient> availableIngredients;
  final Function(AddOnOption) onChanged;
  final VoidCallback onDelete;

  const AddOnOptionEditor({
    super.key,
    required this.option,
    required this.availableIngredients,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  State<AddOnOptionEditor> createState() => _AddOnOptionEditorState();
}

class _AddOnOptionEditorState extends State<AddOnOptionEditor> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late bool _isAvailable;
  late List<int> _selectedIngredientIds;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.option.name);
    _priceController = TextEditingController(
      text: widget.option.price.toString(),
    );
    _isAvailable = widget.option.isAvailable;
    _selectedIngredientIds = List.from(widget.option.ingredientIds ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _notifyChanged() {
    final updatedOption = AddOnOption(
      name: _nameController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      isAvailable: _isAvailable,
      ingredientIds: _selectedIngredientIds.isEmpty
          ? null
          : _selectedIngredientIds,
    );
    widget.onChanged(updatedOption);
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
                    'เลือกวัตถุดิบ',
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
                        _notifyChanged();
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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'ชื่อตัวเลือก',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onChanged: (_) => _notifyChanged(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'ราคา',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _notifyChanged(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: widget.onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _showIngredientSelector,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _selectedIngredientIds.isEmpty
                                  ? 'เลือกวัตถุดิบ...'
                                  : '${_selectedIngredientIds.length} วัตถุดิบ',
                              style: TextStyle(
                                color: _selectedIngredientIds.isEmpty
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    const Text('พร้อมขาย'),
                    Switch(
                      value: _isAvailable,
                      onChanged: (value) {
                        setState(() {
                          _isAvailable = value;
                        });
                        _notifyChanged();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
