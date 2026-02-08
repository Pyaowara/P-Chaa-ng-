import 'package:flutter/foundation.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';

/// IngredientService manages ingredients fetched from the server
class IngredientService extends ChangeNotifier {
  List<Ingredient> _ingredients = [];
  bool _loading = false;
  String? _error;

  List<Ingredient> get ingredients => _ingredients;
  bool get isLoading => _loading;
  String? get error => _error;

  /// Fetch all available ingredients from server
  Future<List<Ingredient>> fetchAllIngredients() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await client.ingredient.getAllIngredients();
      _ingredients = data;
      return _ingredients;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Get a specific ingredient by ID
  Future<Ingredient?> getIngredientById(int id) async {
    try {
      return await client.ingredient.getIngredientById(id);
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  /// Create a new ingredient (requires owner role)
  Future<Ingredient> createIngredient({
    required String name,
    required bool isAvailable,
  }) async {
    try {
      final ingredient = await client.ingredient.createIngredient(
        name,
        isAvailable,
      );
      _ingredients.add(ingredient);
      notifyListeners();
      return ingredient;
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  /// Update an existing ingredient (requires owner role)
  Future<Ingredient> updateIngredient({
    required int id,
    String? name,
    bool? isAvailable,
  }) async {
    try {
      final ingredient = await client.ingredient.updateIngredient(
        id,
        name,
        isAvailable,
      );
      final idx = _ingredients.indexWhere((i) => i.id == id);
      if (idx != -1) {
        _ingredients[idx] = ingredient;
      } else {
        _ingredients.add(ingredient);
      }
      notifyListeners();
      return ingredient;
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  /// Delete an ingredient (requires owner role)
  /// Returns true if successfully deleted
  Future<bool> deleteIngredient(int id) async {
    try {
      final result = await client.ingredient.deleteIngredient(id);
      if (result) {
        _ingredients.removeWhere((i) => i.id == id);
        notifyListeners();
      }
      return result;
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  /// Clear all ingredients from local cache
  void clearCache() {
    _ingredients = [];
    _error = null;
    notifyListeners();
  }
}
