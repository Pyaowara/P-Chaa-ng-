import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/auth_utils.dart';
import '../utils/s3_utils.dart';

class MenuItemEndpoint extends Endpoint {
  Future<MenuItem> createMenuItem(
    Session session,
    String name,
    double basePrice,
    int timeToPrepare,
    List<CustomizationGroup> customization,
    bool isAvailable,
    List<int>? ingredientIds,
    String? imageDataBase64,
    String? imageFileName,
    String? imageContentType,
  ) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);

    if (ingredientIds != null && ingredientIds.isNotEmpty) {
      final fetchedIngredients = await Future.wait(
        ingredientIds.map((id) => Ingredient.db.findById(session, id)),
      );
      final validIngredients = fetchedIngredients
          .where((i) => i != null && !i.isDeleted)
          .cast<Ingredient>()
          .toList();

      if (validIngredients.length != ingredientIds.length) {
        throw Exception('Some ingredient IDs are invalid or deleted');
      }
    }

    String? s3Key;
    String? imageUrl;
    if (imageDataBase64 != null && imageFileName != null) {
      String base64Data = imageDataBase64;
      String? detectedContentType = imageContentType;

      if (imageDataBase64.startsWith('data:')) {
        final parts = imageDataBase64.split(',');
        if (parts.length == 2) {
          final header = parts[0]; // data:image/jpeg;base64
          base64Data = parts[1]; // /9j/4AAQ...

          if (detectedContentType == null) {
            final contentTypeMatch = RegExp(r'data:([^;]+)').firstMatch(header);
            if (contentTypeMatch != null) {
              detectedContentType = contentTypeMatch.group(1);
            }
          }
        }
      }

      final bytes = base64.decode(base64Data);
      s3Key = await S3Utils.uploadMenuImage(
        session,
        imageFileName,
        bytes,
        detectedContentType ?? 'image/jpeg',
      );
      imageUrl = S3Utils.getMenuImageUrl(session, s3Key);
    }

    final newMenuItem = MenuItem(
      name: name,
      basePrice: basePrice,
      timeToPrepare: timeToPrepare,
      customization: customization,
      s3Key: s3Key,
      imageUrl: imageUrl,
      isAvailable: isAvailable,
      createdAt: DateTime.now(),
      ingredientIds: ingredientIds,
      isDeleted: false,
    );

    final insertedMenuItem = await MenuItem.db.insertRow(
      session,
      newMenuItem,
    );

    session.log(
      '[MenuItemEndpoint] Created new menu item: $name',
    );

    return insertedMenuItem;
  }

  Future<List<MenuItem>> getAllMenuItems(
    Session session) async {
    List<MenuItem> menuItems;

      menuItems = await MenuItem.db.find(
        session,
        where: (t) => t.isDeleted.equals(false),
      );

    final menuItemsWithUrls = menuItems.map((item) {
      String? imageUrl;
      if (item.s3Key != null) {
        imageUrl = S3Utils.getMenuImageUrl(session, item.s3Key!);
      }
      return item.copyWith(imageUrl: imageUrl);
    }).toList();

    return menuItemsWithUrls;
  }

  Future<MenuItem?> getMenuItemById(
    Session session,
    int id,
  ) async {
    final menuItem = await MenuItem.db.findById(session, id);

    if (menuItem?.isDeleted == true) {
      return null;
    }

    if (menuItem != null) {
      String? imageUrl;
      if (menuItem.s3Key != null) {
        imageUrl = S3Utils.getMenuImageUrl(session, menuItem.s3Key!);
      }
      return menuItem.copyWith(imageUrl: imageUrl);
    }

    return null;
  }

  Future<MenuItem> updateMenuItem(
    Session session,
    int id,
    String? name,
    double? basePrice,
    int? timeToPrepare,
    List<CustomizationGroup>? customization,
    bool? isAvailable,
    List<int>? ingredientIds,
    bool? removeImage,
    String? imageDataBase64,
    String? imageFileName,
    String? imageContentType,
  ) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);

    final menuItem = await MenuItem.db.findById(session, id);

    if (menuItem == null || menuItem.isDeleted) {
      throw Exception('Menu item not found');
    }

    String? newS3Key = menuItem.s3Key;
    String? newImageUrl = menuItem.imageUrl;

    if (removeImage == true && menuItem.s3Key != null) {
      await S3Utils.deleteMenuImage(session, menuItem.s3Key!);
      newS3Key = null;
      newImageUrl = null;
    }

    if (imageDataBase64 != null && imageFileName != null) {
      if (menuItem.s3Key != null) {
        await S3Utils.deleteMenuImage(session, menuItem.s3Key!);
      }

      String base64Data = imageDataBase64;
      String? detectedContentType = imageContentType;

      if (imageDataBase64.startsWith('data:')) {
        final parts = imageDataBase64.split(',');
        if (parts.length == 2) {
          final header = parts[0]; // data:image/jpeg;base64
          base64Data = parts[1]; // /9j/4AAQ...

          if (detectedContentType == null) {
            final contentTypeMatch = RegExp(r'data:([^;]+)').firstMatch(header);
            if (contentTypeMatch != null) {
              detectedContentType = contentTypeMatch.group(1);
            }
          }
        }
      }

      final bytes = base64.decode(base64Data);
      newS3Key = await S3Utils.uploadMenuImage(
        session,
        imageFileName,
        bytes,
        detectedContentType ?? 'image/jpeg',
      );
      newImageUrl = S3Utils.getMenuImageUrl(session, newS3Key);
    }

    List<int>? newIngredientIds = menuItem.ingredientIds;
    if (ingredientIds != null) {
      if (ingredientIds.isEmpty) {
        newIngredientIds = [];
      } else {
        final fetchedIngredients = await Future.wait(
          ingredientIds.map((id) => Ingredient.db.findById(session, id)),
        );
        final validIngredients = fetchedIngredients
            .where((i) => i != null && !i.isDeleted)
            .cast<Ingredient>()
            .toList();

        if (validIngredients.length != ingredientIds.length) {
          throw Exception('Some ingredient IDs are invalid or deleted');
        }
        newIngredientIds = ingredientIds;
      }
    }

    final updatedMenuItem = menuItem.copyWith(
      name: name ?? menuItem.name,
      basePrice: basePrice ?? menuItem.basePrice,
      timeToPrepare: timeToPrepare ?? menuItem.timeToPrepare,
      customization: customization ?? menuItem.customization,
      s3Key: newS3Key,
      imageUrl: newImageUrl,
      isAvailable: isAvailable ?? menuItem.isAvailable,
      ingredientIds: newIngredientIds,
    );

    final result = await MenuItem.db.updateRow(session, updatedMenuItem);

    session.log(
      '[MenuItemEndpoint] Updated menu item ID: $id',
    );

    return result;
  }

  Future<bool> deleteMenuItem(
    Session session,
    int id,
  ) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);

    final menuItem = await MenuItem.db.findById(session, id);

    if (menuItem == null) {
      throw Exception('Menu item not found');
    }

    final orderItemsWithMenuItem = await OrderItem.db.find(
      session,
      where: (t) => t.menuItemId.equals(id),
    );

    final cartsWithMenuItem = await Cart.db.find(
      session,
      where: (t) => t.menuItemId.equals(id),
    );

    final isReferenced =
        orderItemsWithMenuItem.isNotEmpty || cartsWithMenuItem.isNotEmpty;

    if (isReferenced) {
      final updatedMenuItem = menuItem.copyWith(isDeleted: true);
      await MenuItem.db.updateRow(session, updatedMenuItem);

      session.log(
        '[MenuItemEndpoint] Soft deleted menu item ID: $id',
      );
    } else {
      if (menuItem.s3Key != null) {
        await S3Utils.deleteMenuImage(session, menuItem.s3Key!);
      }
      await MenuItem.db.deleteRow(session, menuItem);

      session.log(
        '[MenuItemEndpoint] Hard deleted menu item ID: $id',
      );
    }

    return true;
  }
}
