import 'package:flutter/foundation.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';

/// CartService manages the user's cart locally and syncs with the server.
class CartService extends ChangeNotifier {
  List<Cart> _items = [];
  bool _loading = false;
  String? _error;

  List<Cart> get items => _items;
  bool get isLoading => _loading;
  String? get error => _error;

  /// Load current cart from server
  Future<void> refresh() async {
    _loading = true;
    _error = null;
    notifyListeners();
    if (googleAuthService.userData?.role == UserRole.owner) return;
    try {
      final data = await client.cart.getMyCart();
      _items = data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Add a new line item to the cart on server and locally
  Future<Cart> add(
    int menuItemId,
    List<SelectedOption> selectedOptions,
    int quantity, {
    String? message,
  }) async {
    final created = await client.cart.createCart(
      menuItemId,
      selectedOptions,
      quantity,
      message,
    );
    _items.add(created);
    notifyListeners();
    await _onCartUpdated(created);
    return created;
  }

  /// Update an existing cart line on server and locally
  Future<Cart> update(
    int cartId,
    List<SelectedOption> selectedOptions,
    int quantity, {
    String? message,
  }) async {
    final updated = await client.cart.updateCart(
      cartId,
      selectedOptions,
      quantity,
      message,
    );
    final idx = _items.indexWhere((c) => c.id == cartId);
    if (idx != -1) {
      _items[idx] = updated;
    } else {
      _items.add(updated);
    }
    notifyListeners();
    await _onCartUpdated(updated);
    return updated;
  }

  /// Remove a cart line from server and locally
  Future<void> remove(int cartId) async {
    await client.cart.deleteCart(cartId);
    _items.removeWhere((c) => c.id == cartId);
    notifyListeners();
    await _onCartUpdated();
  }

  /// Clear the whole cart on server and locally
  Future<void> clear() async {
    await client.cart.clearMyCart();
    _items = [];
    notifyListeners();
    await _onCartUpdated();
  }

  /// Called whenever the cart changes; place your hook call here
  /// For example, this could call "client.cart.doSomething()"
  Future<void> _onCartUpdated([Cart? cart]) async {
    try {
      // Example: re-fetch the cart to verify server state or trigger side-effects
      await client.cart.getMyCart();
      // If you have a specific server hook, replace with: await client.cart.doSomething();
    } catch (_) {
      // Swallow hook errors to avoid breaking UI updates
    }
  }
}
