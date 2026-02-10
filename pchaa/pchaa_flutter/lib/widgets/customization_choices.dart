import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';

class CustomizationChoices extends StatelessWidget {
  final CustomizationGroup customizationGroup;
  final String? selectedValue;
  final Set<String> selectedValues;
  final ValueChanged<String?>? onSingleChanged;
  final ValueChanged<Set<String>>? onMultiChanged;
  const CustomizationChoices({
    super.key,
    required this.customizationGroup,
    this.selectedValue,
    this.selectedValues = const <String>{},
    this.onSingleChanged,
    this.onMultiChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            customizationGroup.title,
            style: TextStyle(fontSize: 18),
          ),
          if (customizationGroup.pickOne)
            _buildSingleCheckboxGroup(customizationGroup.choices)
          else
            _buildCheckboxGroup(customizationGroup.choices),
        ],
      ),
    );
  }

  Widget _buildSingleCheckboxGroup(List<AddOnOption> choices) {
    return Column(
      children: choices.map((choice) {
        final isChecked = selectedValue == choice.name;
        final hasSelection = selectedValue != null && selectedValue!.isNotEmpty;
        final isUnavailable = !choice.isAvailable;
        final isDisabled = isUnavailable || (hasSelection && !isChecked);

        return Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: CheckboxListTile(
            activeColor: Color(0xFF5A9CB5),
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            enableFeedback: false,
            value: isChecked,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    choice.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 20,),
                Text("฿${choice.price.toString()}"),
              ],
            ),
            onChanged: isDisabled
                ? null
                : (checked) {
                    if (onSingleChanged == null) return;
                    if (checked == true) {
                      onSingleChanged!(choice.name);
                    } else {
                      onSingleChanged!(null);
                    }
                  },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCheckboxGroup(List<AddOnOption> choices) {
    return Column(
      children: choices.map((choice) {
        final isChecked = selectedValues.contains(choice.name);
        final isUnavailable = !choice.isAvailable;

        return Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: CheckboxListTile(
            activeColor: Color(0xFF5A9CB5),
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6), // 👈 increase this
            ),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            enableFeedback: false,
            value: isChecked,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    choice.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text("฿${choice.price.toString()}"),
              ],
            ),
            onChanged: isUnavailable
                ? null
                : (checked) {
                    final newValues = Set<String>.from(selectedValues);
                    checked == true
                        ? newValues.add(choice.name)
                        : newValues.remove(choice.name);
                    onMultiChanged?.call(newValues);
                  },
          ),
        );
      }).toList(),
    );
  }
}
