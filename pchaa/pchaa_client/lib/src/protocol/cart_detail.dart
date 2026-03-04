/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'carts.dart' as _i2;
import 'package:pchaa_client/src/protocol/protocol.dart' as _i3;

abstract class CartDetail implements _i1.SerializableModel {
  CartDetail._({
    required this.cart,
    required this.menuItemName,
  });

  factory CartDetail({
    required _i2.Cart cart,
    required String menuItemName,
  }) = _CartDetailImpl;

  factory CartDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return CartDetail(
      cart: _i3.Protocol().deserialize<_i2.Cart>(jsonSerialization['cart']),
      menuItemName: jsonSerialization['menuItemName'] as String,
    );
  }

  _i2.Cart cart;

  String menuItemName;

  /// Returns a shallow copy of this [CartDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CartDetail copyWith({
    _i2.Cart? cart,
    String? menuItemName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CartDetail',
      'cart': cart.toJson(),
      'menuItemName': menuItemName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CartDetailImpl extends CartDetail {
  _CartDetailImpl({
    required _i2.Cart cart,
    required String menuItemName,
  }) : super._(
         cart: cart,
         menuItemName: menuItemName,
       );

  /// Returns a shallow copy of this [CartDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CartDetail copyWith({
    _i2.Cart? cart,
    String? menuItemName,
  }) {
    return CartDetail(
      cart: cart ?? this.cart.copyWith(),
      menuItemName: menuItemName ?? this.menuItemName,
    );
  }
}
