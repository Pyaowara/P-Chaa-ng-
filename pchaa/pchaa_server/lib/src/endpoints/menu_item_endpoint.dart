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
    }

    final newMenuItem = MenuItem(
      name: name,
      basePrice: basePrice,
      timeToPrepare: timeToPrepare,
      customization: customization,
      s3Key: s3Key,
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

  Future<List<MenuItemWithUrl>> getAllMenuItems(Session session) async {
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
      return MenuItemWithUrl(
        id: item.id,
        name: item.name,
        basePrice: item.basePrice,
        timeToPrepare: item.timeToPrepare,
        customization: item.customization,
        s3Key: item.s3Key,
        imageUrl: imageUrl,
        isAvailable: item.isAvailable,
        createdAt: item.createdAt,
        ingredientIds: item.ingredientIds,
        isDeleted: item.isDeleted,
      );
    }).toList();

    return menuItemsWithUrls;
  }

  Future<MenuItemWithUrl?> getMenuItemById(
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
      return MenuItemWithUrl(
        id: menuItem.id,
        name: menuItem.name,
        basePrice: menuItem.basePrice,
        timeToPrepare: menuItem.timeToPrepare,
        customization: menuItem.customization,
        s3Key: menuItem.s3Key,
        imageUrl: imageUrl,
        isAvailable: menuItem.isAvailable,
        createdAt: menuItem.createdAt,
        ingredientIds: menuItem.ingredientIds,
        isDeleted: menuItem.isDeleted,
      );
    }

    return null;
  }

  Future<List<AvailableMenuItem>> getAllAvailableMenuItems(
    Session session,
  ) async {
    final menuItems = await MenuItem.db.find(
      session,
      where: (t) => t.isDeleted.equals(false),
    );

    List<AvailableMenuItem> availableMenuItems = [];

    for (final menuItem in menuItems) {
      Set<int> allIngredientIds = {};
      if (menuItem.ingredientIds != null) {
        allIngredientIds.addAll(menuItem.ingredientIds!);
      }
      for (final group in menuItem.customization) {
        for (final choice in group.choices) {
          if (choice.ingredientIds != null) {
            allIngredientIds.addAll(choice.ingredientIds!);
          }
        }
      }

      final ingredients = await Future.wait(
        allIngredientIds.map((id) => Ingredient.db.findById(session, id)),
      );

      final availableIngredientIds = ingredients
          .where((ing) => ing != null && !ing.isDeleted && ing.isAvailable)
          .map((ing) => ing!.id!)
          .toSet();

      final menuIngredientsAvailable =
          menuItem.ingredientIds == null ||
          menuItem.ingredientIds!.every(
            (id) => availableIngredientIds.contains(id),
          );
      final menuForSale = menuItem.isAvailable && menuIngredientsAvailable;

      List<AvailableCustomizationGroup> availableCustomization = [];
      for (final group in menuItem.customization) {
        List<AvailableAddOnOption> availableChoices = [];
        for (final choice in group.choices) {
          final choiceIngredientsAvailable =
              choice.ingredientIds == null ||
              choice.ingredientIds!.every(
                (id) => availableIngredientIds.contains(id),
              );
          final choiceForSale =
              choice.isAvailable && choiceIngredientsAvailable;

          availableChoices.add(
            AvailableAddOnOption(
              name: choice.name,
              price: choice.price,
              isAvailable: choice.isAvailable,
              ingredientIds: choice.ingredientIds,
              forSale: choiceForSale,
            ),
          );
        }
        availableCustomization.add(
          AvailableCustomizationGroup(
            title: group.title,
            pickOne: group.pickOne,
            choices: availableChoices,
          ),
        );
      }

      String? imageUrl;
      if (menuItem.s3Key != null) {
        imageUrl = S3Utils.getMenuImageUrl(session, menuItem.s3Key!);
      }

      availableMenuItems.add(
        AvailableMenuItem(
          id: menuItem.id,
          name: menuItem.name,
          basePrice: menuItem.basePrice,
          timeToPrepare: menuItem.timeToPrepare,
          customization: availableCustomization,
          s3Key: menuItem.s3Key,
          imageUrl: imageUrl,
          isAvailable: menuItem.isAvailable,
          createdAt: menuItem.createdAt,
          ingredientIds: menuItem.ingredientIds,
          isDeleted: menuItem.isDeleted,
          forSale: menuForSale,
        ),
      );
    }

    return availableMenuItems;
  }

  Future<AvailableMenuItem?> getAvailableMenuItemById(
    Session session,
    int id,
  ) async {
    final menuItem = await MenuItem.db.findById(session, id);

    if (menuItem == null || menuItem.isDeleted) {
      return null;
    }

    Set<int> allIngredientIds = {};
    if (menuItem.ingredientIds != null) {
      allIngredientIds.addAll(menuItem.ingredientIds!);
    }
    for (final group in menuItem.customization) {
      for (final choice in group.choices) {
        if (choice.ingredientIds != null) {
          allIngredientIds.addAll(choice.ingredientIds!);
        }
      }
    }

    final ingredients = await Future.wait(
      allIngredientIds.map((id) => Ingredient.db.findById(session, id)),
    );

    final availableIngredientIds = ingredients
        .where((ing) => ing != null && !ing.isDeleted && ing.isAvailable)
        .map((ing) => ing!.id!)
        .toSet();

    final menuIngredientsAvailable =
        menuItem.ingredientIds == null ||
        menuItem.ingredientIds!.every(
          (id) => availableIngredientIds.contains(id),
        );
    final menuForSale = menuItem.isAvailable && menuIngredientsAvailable;

    List<AvailableCustomizationGroup> availableCustomization = [];
    for (final group in menuItem.customization) {
      List<AvailableAddOnOption> availableChoices = [];
      for (final choice in group.choices) {
        final choiceIngredientsAvailable =
            choice.ingredientIds == null ||
            choice.ingredientIds!.every(
              (id) => availableIngredientIds.contains(id),
            );
        final choiceForSale = choice.isAvailable && choiceIngredientsAvailable;

        availableChoices.add(
          AvailableAddOnOption(
            name: choice.name,
            price: choice.price,
            isAvailable: choice.isAvailable,
            ingredientIds: choice.ingredientIds,
            forSale: choiceForSale,
          ),
        );
      }
      availableCustomization.add(
        AvailableCustomizationGroup(
          title: group.title,
          pickOne: group.pickOne,
          choices: availableChoices,
        ),
      );
    }

    String? imageUrl;
    if (menuItem.s3Key != null) {
      imageUrl = S3Utils.getMenuImageUrl(session, menuItem.s3Key!);
    }

    return AvailableMenuItem(
      id: menuItem.id,
      name: menuItem.name,
      basePrice: menuItem.basePrice,
      timeToPrepare: menuItem.timeToPrepare,
      customization: availableCustomization,
      s3Key: menuItem.s3Key,
      imageUrl: imageUrl,
      isAvailable: menuItem.isAvailable,
      createdAt: menuItem.createdAt,
      ingredientIds: menuItem.ingredientIds,
      isDeleted: menuItem.isDeleted,
      forSale: menuForSale,
    );
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

    if (removeImage == true && menuItem.s3Key != null) {
      await S3Utils.deleteMenuImage(session, menuItem.s3Key!);
      newS3Key = null;
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
