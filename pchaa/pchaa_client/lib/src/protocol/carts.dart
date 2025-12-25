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
import 'selected_option.dart' as _i2;
import 'package:pchaa_client/src/protocol/protocol.dart' as _i3;

abstract class Cart implements _i1.SerializableModel {
  Cart._({
    this.id,
    required this.userId,
    required this.menuItemId,
    required this.selectedOptions,
    this.additionalMessage,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.createdAt,
  });

  factory Cart({
    int? id,
    required int userId,
    required int menuItemId,
    required List<_i2.SelectedOption> selectedOptions,
    String? additionalMessage,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    DateTime? createdAt,
  }) = _CartImpl;

  factory Cart.fromJson(Map<String, dynamic> jsonSerialization) {
    return Cart(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      menuItemId: jsonSerialization['menuItemId'] as int,
      selectedOptions: _i3.Protocol().deserialize<List<_i2.SelectedOption>>(
        jsonSerialization['selectedOptions'],
      ),
      additionalMessage: jsonSerialization['additionalMessage'] as String?,
      quantity: jsonSerialization['quantity'] as int,
      unitPrice: (jsonSerialization['unitPrice'] as num).toDouble(),
      totalPrice: (jsonSerialization['totalPrice'] as num).toDouble(),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int menuItemId;

  List<_i2.SelectedOption> selectedOptions;

  String? additionalMessage;

  int quantity;

  double unitPrice;

  double totalPrice;

  DateTime? createdAt;

  /// Returns a shallow copy of this [Cart]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Cart copyWith({
    int? id,
    int? userId,
    int? menuItemId,
    List<_i2.SelectedOption>? selectedOptions,
    String? additionalMessage,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Cart',
      if (id != null) 'id': id,
      'userId': userId,
      'menuItemId': menuItemId,
      'selectedOptions': selectedOptions.toJson(valueToJson: (v) => v.toJson()),
      if (additionalMessage != null) 'additionalMessage': additionalMessage,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CartImpl extends Cart {
  _CartImpl({
    int? id,
    required int userId,
    required int menuItemId,
    required List<_i2.SelectedOption> selectedOptions,
    String? additionalMessage,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         menuItemId: menuItemId,
         selectedOptions: selectedOptions,
         additionalMessage: additionalMessage,
         quantity: quantity,
         unitPrice: unitPrice,
         totalPrice: totalPrice,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Cart]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Cart copyWith({
    Object? id = _Undefined,
    int? userId,
    int? menuItemId,
    List<_i2.SelectedOption>? selectedOptions,
    Object? additionalMessage = _Undefined,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    Object? createdAt = _Undefined,
  }) {
    return Cart(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      menuItemId: menuItemId ?? this.menuItemId,
      selectedOptions:
          selectedOptions ??
          this.selectedOptions.map((e0) => e0.copyWith()).toList(),
      additionalMessage: additionalMessage is String?
          ? additionalMessage
          : this.additionalMessage,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}
