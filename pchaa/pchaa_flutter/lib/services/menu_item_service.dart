import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';

/// MenuItemService manages menu items fetched from the server
class MenuItemService extends ChangeNotifier {
  List<MenuItemWithUrl> _menuItems = [];
  bool _loading = false;
  String? _error;

  List<MenuItemWithUrl> get menuItems => _menuItems;
  bool get isLoading => _loading;
  String? get error => _error;

  /// Fetch all menu items from server
  Future<List<MenuItemWithUrl>> fetchAllMenuItems() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await client.menuItem.getAllMenuItems();
      _menuItems = data;
      return _menuItems;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Get a specific menu item by ID
  Future<MenuItemWithUrl?> getMenuItemById(int id) async {
    try {
      return await client.menuItem.getMenuItemById(id);
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  /// Create a new menu item (requires owner role)
  Future<MenuItem> createMenuItem({
    required String name,
    required double basePrice,
    required int timeToPrepare,
    required List<CustomizationGroup> customization,
    required bool isAvailable,
    List<int>? ingredientIds,
    XFile? imageFile,
  }) async {
    try {
      String? imageDataBase64;
      String? imageFileName;
      String? imageContentType;

      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        imageDataBase64 = base64Encode(bytes);
        imageFileName = imageFile.name;
        imageContentType = imageFile.mimeType ?? 'image/jpeg';
      }

      final menuItem = await client.menuItem.createMenuItem(
        name,
        basePrice,
        timeToPrepare,
        customization,
        isAvailable,
        ingredientIds,
        imageDataBase64,
        imageFileName,
        imageContentType,
      );

      // Refresh the list
      await fetchAllMenuItems();
      return menuItem;
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  /// Update an existing menu item (requires owner role)
  Future<MenuItem> updateMenuItem({
    required int id,
    String? name,
    double? basePrice,
    int? timeToPrepare,
    List<CustomizationGroup>? customization,
    bool? isAvailable,
    List<int>? ingredientIds,
    bool? removeImage,
    XFile? imageFile,
  }) async {
    try {
      String? imageDataBase64;
      String? imageFileName;
      String? imageContentType;

      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        imageDataBase64 = base64Encode(bytes);
        imageFileName = imageFile.name;
        imageContentType = imageFile.mimeType ?? 'image/jpeg';
      }

      final menuItem = await client.menuItem.updateMenuItem(
        id,
        name,
        basePrice,
        timeToPrepare,
        customization,
        isAvailable,
        ingredientIds,
        removeImage,
        imageDataBase64,
        imageFileName,
        imageContentType,
      );

      // Refresh the list
      await fetchAllMenuItems();
      return menuItem;
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  /// Delete a menu item (requires owner role)
  Future<bool> deleteMenuItem(int id) async {
    try {
      final result = await client.menuItem.deleteMenuItem(id);
      if (result) {
        await fetchAllMenuItems();
      }
      return result;
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  /// Clear all menu items from local cache
  void clearCache() {
    _menuItems = [];
    _error = null;
    notifyListeners();
  }
}
