import 'package:pchaa_server/src/utils/thailand_time_utils.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/auth_utils.dart';
import '../utils/menu_items_utils.dart';

class CartEndpoint extends Endpoint {

  Future<List<Cart>> getMyCart(Session session) async {
    final user =await AuthUtils.allowedRoles(session, [UserRole.user]);
    
    final carts = await Cart.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
    session.log("[CartEndpoint] Fetched cart for userId: ${user.id}");
    return carts;
  }

  Future<Cart> getCartById(Session session, int cartId) async {
    final user = await AuthUtils.allowedRoles(session, [UserRole.user]);
    
    final cart = await Cart.db.findById(session, cartId);
    if (cart == null) {
      throw Exception('Cart not found');
    }
    if (cart.userId != user.id!) {
      throw Exception('Access denied: Can\'t access cart of another user');
    }
    session.log("[CartEndpoint] Fetched cart with id: $cartId for userId: ${user.id}");
    return cart;
  }

  Future<Cart> createCart(Session session, int menuItemId, List<SelectedOption> selectedOptions, int quantity, String? additionalMessage) async {
    final user = await AuthUtils.allowedRoles(session, [UserRole.user]);
    final menuItem = await MenuItem.db.findById(session, menuItemId);
    if (menuItem == null) {
      throw Exception('Menu item not found');
    }
    if ((!menuItem.isAvailable) || (menuItem.isDeleted)) {
      throw Exception('Menu item is not available');
    }
    if (quantity <= 0) {
      throw Exception('Quantity must be greater than zero');
    }

    // Validate selected options
    await MenuItemsUtils.checkMenuAvailable(session, menuItemId, selectedOptions);
    
    // calculate unitPrice and totalPrice
    double unitPrice = menuItem.basePrice;
    for (var option in selectedOptions) {
      unitPrice += option.price;
    }
    double totalPrice = unitPrice * quantity;

    final cart = Cart(
      userId: user.id!,
      menuItemId: menuItemId,
      selectedOptions: selectedOptions,
      quantity: quantity,
      additionalMessage: additionalMessage, 
      unitPrice: unitPrice, 
      totalPrice: totalPrice,
      createdAt : ThailandTimeUtils.getThailandDate(),
    );
    await Cart.db.insert(session, [cart]);
    session.log("[CartEndpoint] Created cart for userId: ${user.id}");
    return cart;
  }

  Future<Cart> updateCart(Session session, int cartId, List<SelectedOption> selectedOptions, int quantity, String? additionalMessage) async {
    final user = await AuthUtils.allowedRoles(session, [UserRole.user]);
    final cart = await Cart.db.findById(session, cartId);
    if (cart == null) {
      throw Exception('Cart not found');
    }
    if (cart.userId != user.id!) {
      throw Exception('Access denied: Can\'t modify cart of another user');
    }
    final menuItem = await MenuItem.db.findById(session, cart.menuItemId);
    if (menuItem == null) {
      throw Exception('Menu item not found');
    }
    if ((!menuItem.isAvailable) || (menuItem.isDeleted)) {
      throw Exception('Menu item is not available');
    }
    if (quantity <= 0) {
      throw Exception('Quantity must be greater than zero');
    }
    
    // Validate selected options
    await MenuItemsUtils.checkMenuAvailable(session, cart.menuItemId, selectedOptions);
    
    // calculate unitPrice and totalPrice
    double unitPrice = menuItem.basePrice;
    for (var option in selectedOptions) {
      unitPrice += option.price;
    }
    double totalPrice = unitPrice * quantity;

    cart.selectedOptions = selectedOptions;
    cart.quantity = quantity;
    cart.additionalMessage = additionalMessage;
    cart.unitPrice = unitPrice;
    cart.totalPrice = totalPrice;

    await Cart.db.update(session, [cart]);
    session.log("[CartEndpoint] Updated cart with id: ${cart.id} for userId: ${user.id}");
    return cart;
  }

  Future<void> deleteCart(Session session, int cartId) async {
    final user = await AuthUtils.allowedRoles(session, [UserRole.user]);
    final cart = await Cart.db.findById(session, cartId);
    if (cart == null) {
      throw Exception('Cart not found');
    }
    if (cart.userId != user.id!) {
      throw Exception('Access denied: Can\'t delete cart of another user');
    }
    await Cart.db.delete(session, [cart]);
    session.log("[CartEndpoint] Deleted cart with id: $cartId for userId: ${user.id}");
  }

  Future<void> clearMyCart(Session session) async {
    final user = await AuthUtils.allowedRoles(session, [UserRole.user]);
    final mycarts = await Cart.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
    await Cart.db.delete(
      session,
      mycarts,
    );
    session.log("[CartEndpoint] Cleared cart for userId: ${user.id}");
  }


}