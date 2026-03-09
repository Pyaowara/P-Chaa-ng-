import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/widgets/menu_detail/customization_choices.dart';
import 'package:pchaa_flutter/widgets/menu_detail/menu_detail_header.dart';

class MenuDetailContent extends StatelessWidget {
  final AvailableMenuItem? menuDetail;
  final String? errorMsg;
  final TextEditingController messageController;
  final Set<String> Function(AvailableCustomizationGroup) getSelectedNamesForGroup;
  final void Function(AvailableCustomizationGroup, String?) onSingleChanged;
  final void Function(AvailableCustomizationGroup, Set<String>) onMultiChanged;

  const MenuDetailContent({
    super.key,
    required this.menuDetail,
    required this.errorMsg,
    required this.messageController,
    required this.getSelectedNamesForGroup,
    required this.onSingleChanged,
    required this.onMultiChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMsg != null) {
      return Center(child: Text(errorMsg!));
    }
    if (menuDetail == null) {
      return const Center(child: Text("No Menu Detail"));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuDetailHeader(imageUrl: menuDetail?.imageUrl),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              top: 10,
              right: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menuDetail!.name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Divider(),
                ),

                if (menuDetail!.customization.isNotEmpty)
                  ...menuDetail!.customization.map((customization) {
                    final selectedValues = getSelectedNamesForGroup(customization);
                    final selectedValue = selectedValues.isNotEmpty
                        ? selectedValues.first
                        : null;
                    return CustomizationChoices(
                      customizationGroup: customization,
                      selectedValue: selectedValue,
                      selectedValues: selectedValues,
                      onSingleChanged: (value) => onSingleChanged(customization, value),
                      onMultiChanged: (values) => onMultiChanged(customization, values),
                    );
                  }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Divider(),
                ),
                const Text(
                  "เพิ่มเติม",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: messageController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'โน๊ตเพิ่มเติม',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
