import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/auth_utils.dart';

class IngredientEndpoint extends Endpoint {
  Future<Ingredient> createIngredient(
    Session session,
    String name,
    bool isAvailable,
  ) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);

    final newIngredient = Ingredient(
      name: name,
      isAvailable: isAvailable,
      isDeleted: false,
    );

    final insertedIngredient = await Ingredient.db.insertRow(
      session,
      newIngredient,
    );

    session.log(
      '[IngredientEndpoint] Created new ingredient: $name',
    );

    return insertedIngredient;
  }

  Future<List<Ingredient>> getAllIngredients(
    Session session) async {
    return await Ingredient.db.find(
      session,
      where: (t) => t.isDeleted.equals(false),
    );
  }

  Future<Ingredient?> getIngredientById(
    Session session,
    int id,
  ) async {
    final ingredient = await Ingredient.db.findById(session, id);

    if (ingredient?.isDeleted == true) {
      return null;
    }

    return ingredient;
  }

  Future<Ingredient> updateIngredient(
    Session session,
    int id,
    String? name,
    bool? isAvailable,
  ) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);

    final ingredient = await Ingredient.db.findById(session, id);

    if (ingredient == null || ingredient.isDeleted) {
      throw Exception('Ingredient not found');
    }

    final updatedIngredient = ingredient.copyWith(
      name: name ?? ingredient.name,
      isAvailable: isAvailable ?? ingredient.isAvailable,
    );

    final result = await Ingredient.db.updateRow(session, updatedIngredient);

    session.log(
      '[IngredientEndpoint] Updated ingredient ID: $id',
    );

    return result;
  }

  Future<bool> deleteIngredient(
    Session session,
    int id,
  ) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);

    final ingredient = await Ingredient.db.findById(session, id);

    if (ingredient == null) {
      throw Exception('Ingredient not found');
    }

    final allMenuItems = await MenuItem.db.find(session);
    final menuItemsWithIngredient = allMenuItems.where((menuItem) {
      final menuIngredients = menuItem.ingredientIds ?? [];
      if (menuIngredients.contains(id)) {
        return true;
      }

      for (final customizationGroup in menuItem.customization) {
        for (final addOn in customizationGroup.choices) {
          final addOnIngredientIds = addOn.ingredientIds ?? [];
          if (addOnIngredientIds.contains(id)) {
            return true;
          }
        }
      }

      return false;
    }).toList();

    final isReferenced = menuItemsWithIngredient.isNotEmpty;

    if (isReferenced) {
      final updatedIngredient = ingredient.copyWith(isDeleted: true);
      await Ingredient.db.updateRow(session, updatedIngredient);

      session.log(
        '[IngredientEndpoint] Soft deleted ingredient ID: $id',
      );
    } else {
      await Ingredient.db.deleteRow(session, ingredient);

      session.log(
        '[IngredientEndpoint] Hard deleted ingredient ID: $id',
      );
    }

    return true;
  }
}
