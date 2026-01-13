import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class MenuItemsUtils {
  static Future<bool> checkMenuAvailable(
    Session session,
    int menuItemId,
    List<SelectedOption> selectedOptions,
  ) async {
    final menuItem = await MenuItem.db.findById(session, menuItemId);
    if (menuItem == null) {
      throw Exception('Menu item not found');
    } else if (!menuItem.isAvailable || menuItem.isDeleted) {
      throw Exception('Menu item is not available');
    }
    Set<int> ingredients = {};
    if (menuItem.ingredientIds != null) {
      ingredients.addAll(menuItem.ingredientIds!);
    }
    final customizations = menuItem.customization;
    if (customizations.isEmpty && selectedOptions.isNotEmpty) {
      throw Exception('No customization options available for this menu item');
    }
    final nonGroupedSelections = selectedOptions.where(
      (option) => !customizations
          .map((group) => group.title)
          .contains(option.groupTitle),
    );
    if (nonGroupedSelections.isNotEmpty) {
      throw Exception(
        'Invalid customization options selected: ${nonGroupedSelections.map((e) => e.groupTitle).join(', ')}',
      );
    }
    for (var customization in customizations) {
      final selected = selectedOptions
          .where((options) => options.groupTitle == customization.title)
          .toList();
      if (customization.pickOne && selected.length > 1) {
        throw Exception(
          'You must select exactly one option for ${customization.title}',
        );

      } 
      else {
        for (var option in selected) {
          final matchedOption = customization.choices.where(
            (choice) => choice.name == option.name,
          );
          if (matchedOption.isEmpty) {
            throw Exception(
              'Invalid choice ${option.name} for customization group ${customization.title}',
            );
          } 
          else if (matchedOption.first.isAvailable == false) {
            throw Exception(
              'Choice ${option.name} for customization group ${customization.title} is not available',
            );
          }
          else {
            for (var choice in matchedOption) {
              if (choice.ingredientIds != null) {
                ingredients.addAll(choice.ingredientIds!);
              }
            }
          }
        }
      }
    }
    final allIngredients = await Future.wait(
        ingredients.map((id) => Ingredient.db.findById(session, id)),
      );

      final availableIngredientIds = allIngredients
          .where((ing) => ing != null && !ing.isDeleted && ing.isAvailable)
          .map((ing) => ing!.id!)
          .toSet();

      final isAvailable = ingredients.every(
        (id) => availableIngredientIds.contains(id),
      );
      if (!isAvailable) {
        throw Exception('One or more ingredients are not available');
      }
    return true;
  }
}
