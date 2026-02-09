import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/widgets/add_menu/add_on_option_editor.dart';

/// Widget for editing a customization group with its options
class CustomizationGroupEditor extends StatefulWidget {
  final CustomizationGroup group;
  final List<Ingredient> availableIngredients;
  final Function(CustomizationGroup) onChanged;
  final VoidCallback onDelete;

  const CustomizationGroupEditor({
    super.key,
    required this.group,
    required this.availableIngredients,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  State<CustomizationGroupEditor> createState() =>
      _CustomizationGroupEditorState();
}

class _CustomizationGroupEditorState extends State<CustomizationGroupEditor> {
  late TextEditingController _titleController;
  late bool _pickOne;
  late List<AddOnOption> _choices;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.group.title);
    _pickOne = widget.group.pickOne;
    _choices = List.from(widget.group.choices);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _notifyChanged() {
    final updatedGroup = CustomizationGroup(
      title: _titleController.text,
      pickOne: _pickOne,
      choices: _choices,
    );
    widget.onChanged(updatedGroup);
  }

  void _addOption() {
    setState(() {
      _choices.add(
        AddOnOption(
          name: '',
          price: 0,
          isAvailable: true,
        ),
      );
    });
    _notifyChanged();
  }

  void _updateOption(int index, AddOnOption option) {
    setState(() {
      _choices[index] = option;
    });
    _notifyChanged();
  }

  void _deleteOption(int index) {
    setState(() {
      _choices.removeAt(index);
    });
    _notifyChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'ชื่อกลุ่มตัวเลือก',
                      hintText: 'เช่น ระดับความหวาน, ท็อปปิ้ง',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => _notifyChanged(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: widget.onDelete,
                  tooltip: 'ลบกลุ่มตัวเลือก',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('เลือกได้ตัวเลือกเดียว'),
                Switch(
                  value: _pickOne,
                  onChanged: (value) {
                    setState(() {
                      _pickOne = value;
                    });
                    _notifyChanged();
                  },
                ),
              ],
            ),
            const Divider(),
            const Text(
              'ตัวเลือก',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            ..._choices.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return AddOnOptionEditor(
                key: ValueKey('option_$index'),
                option: option,
                availableIngredients: widget.availableIngredients,
                onChanged: (updated) => _updateOption(index, updated),
                onDelete: () => _deleteOption(index),
              );
            }),
            const SizedBox(height: 8),
            Center(
              child: TextButton.icon(
                onPressed: _addOption,
                icon: const Icon(Icons.add),
                label: const Text('เพิ่มตัวเลือก'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
