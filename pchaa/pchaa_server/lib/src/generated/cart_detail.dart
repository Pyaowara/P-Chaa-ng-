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
import 'package:serverpod/serverpod.dart' as _i1;
import 'carts.dart' as _i2;
import 'package:pchaa_server/src/generated/protocol.dart' as _i3;

abstract class CartDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CartDetail._({
    required this.cart,
    required this.menuItemName,
    required this.imageUrl,
  });

  factory CartDetail({
    required _i2.Cart cart,
    required String menuItemName,
    required String imageUrl,
  }) = _CartDetailImpl;

  factory CartDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return CartDetail(
      cart: _i3.Protocol().deserialize<_i2.Cart>(jsonSerialization['cart']),
      menuItemName: jsonSerialization['menuItemName'] as String,
      imageUrl: jsonSerialization['imageUrl'] as String,
    );
  }

  _i2.Cart cart;

  String menuItemName;

  String imageUrl;

  /// Returns a shallow copy of this [CartDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CartDetail copyWith({
    _i2.Cart? cart,
    String? menuItemName,
    String? imageUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CartDetail',
      'cart': cart.toJson(),
      'menuItemName': menuItemName,
      'imageUrl': imageUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CartDetail',
      'cart': cart.toJsonForProtocol(),
      'menuItemName': menuItemName,
      'imageUrl': imageUrl,
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
    required String imageUrl,
  }) : super._(
         cart: cart,
         menuItemName: menuItemName,
         imageUrl: imageUrl,
       );

  /// Returns a shallow copy of this [CartDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CartDetail copyWith({
    _i2.Cart? cart,
    String? menuItemName,
    String? imageUrl,
  }) {
    return CartDetail(
      cart: cart ?? this.cart.copyWith(),
      menuItemName: menuItemName ?? this.menuItemName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
