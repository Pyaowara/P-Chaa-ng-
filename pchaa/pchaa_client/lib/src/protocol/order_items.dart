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

abstract class OrderItem implements _i1.SerializableModel {
  OrderItem._({
    this.id,
    required this.orderId,
    this.menuItemId,
    required this.itemName,
    required this.selectedOptions,
    this.additionalMessage,
    required this.quantity,
    required this.finalPrice,
  });

  factory OrderItem({
    int? id,
    required int orderId,
    int? menuItemId,
    required String itemName,
    required List<_i2.SelectedOption> selectedOptions,
    String? additionalMessage,
    required int quantity,
    required double finalPrice,
  }) = _OrderItemImpl;

  factory OrderItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderItem(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      menuItemId: jsonSerialization['menuItemId'] as int?,
      itemName: jsonSerialization['itemName'] as String,
      selectedOptions: _i3.Protocol().deserialize<List<_i2.SelectedOption>>(
        jsonSerialization['selectedOptions'],
      ),
      additionalMessage: jsonSerialization['additionalMessage'] as String?,
      quantity: jsonSerialization['quantity'] as int,
      finalPrice: (jsonSerialization['finalPrice'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orderId;

  int? menuItemId;

  String itemName;

  List<_i2.SelectedOption> selectedOptions;

  String? additionalMessage;

  int quantity;

  double finalPrice;

  /// Returns a shallow copy of this [OrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderItem copyWith({
    int? id,
    int? orderId,
    int? menuItemId,
    String? itemName,
    List<_i2.SelectedOption>? selectedOptions,
    String? additionalMessage,
    int? quantity,
    double? finalPrice,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderItem',
      if (id != null) 'id': id,
      'orderId': orderId,
      if (menuItemId != null) 'menuItemId': menuItemId,
      'itemName': itemName,
      'selectedOptions': selectedOptions.toJson(valueToJson: (v) => v.toJson()),
      if (additionalMessage != null) 'additionalMessage': additionalMessage,
      'quantity': quantity,
      'finalPrice': finalPrice,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderItemImpl extends OrderItem {
  _OrderItemImpl({
    int? id,
    required int orderId,
    int? menuItemId,
    required String itemName,
    required List<_i2.SelectedOption> selectedOptions,
    String? additionalMessage,
    required int quantity,
    required double finalPrice,
  }) : super._(
         id: id,
         orderId: orderId,
         menuItemId: menuItemId,
         itemName: itemName,
         selectedOptions: selectedOptions,
         additionalMessage: additionalMessage,
         quantity: quantity,
         finalPrice: finalPrice,
       );

  /// Returns a shallow copy of this [OrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderItem copyWith({
    Object? id = _Undefined,
    int? orderId,
    Object? menuItemId = _Undefined,
    String? itemName,
    List<_i2.SelectedOption>? selectedOptions,
    Object? additionalMessage = _Undefined,
    int? quantity,
    double? finalPrice,
  }) {
    return OrderItem(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      menuItemId: menuItemId is int? ? menuItemId : this.menuItemId,
      itemName: itemName ?? this.itemName,
      selectedOptions:
          selectedOptions ??
          this.selectedOptions.map((e0) => e0.copyWith()).toList(),
      additionalMessage: additionalMessage is String?
          ? additionalMessage
          : this.additionalMessage,
      quantity: quantity ?? this.quantity,
      finalPrice: finalPrice ?? this.finalPrice,
    );
  }
}
