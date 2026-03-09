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
import 'orders.dart' as _i2;
import 'order_items.dart' as _i3;
import 'package:pchaa_server/src/generated/protocol.dart' as _i4;

abstract class OrderWithEstimated
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  OrderWithEstimated._({
    required this.order,
    required this.orderItems,
    this.estimatedPrepTime,
    this.queueLength,
  });

  factory OrderWithEstimated({
    required _i2.Order order,
    required List<_i3.OrderItem> orderItems,
    int? estimatedPrepTime,
    int? queueLength,
  }) = _OrderWithEstimatedImpl;

  factory OrderWithEstimated.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderWithEstimated(
      order: _i4.Protocol().deserialize<_i2.Order>(jsonSerialization['order']),
      orderItems: _i4.Protocol().deserialize<List<_i3.OrderItem>>(
        jsonSerialization['orderItems'],
      ),
      estimatedPrepTime: jsonSerialization['estimatedPrepTime'] as int?,
      queueLength: jsonSerialization['queueLength'] as int?,
    );
  }

  _i2.Order order;

  List<_i3.OrderItem> orderItems;

  int? estimatedPrepTime;

  int? queueLength;

  /// Returns a shallow copy of this [OrderWithEstimated]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderWithEstimated copyWith({
    _i2.Order? order,
    List<_i3.OrderItem>? orderItems,
    int? estimatedPrepTime,
    int? queueLength,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderWithEstimated',
      'order': order.toJson(),
      'orderItems': orderItems.toJson(valueToJson: (v) => v.toJson()),
      if (estimatedPrepTime != null) 'estimatedPrepTime': estimatedPrepTime,
      if (queueLength != null) 'queueLength': queueLength,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderWithEstimated',
      'order': order.toJsonForProtocol(),
      'orderItems': orderItems.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (estimatedPrepTime != null) 'estimatedPrepTime': estimatedPrepTime,
      if (queueLength != null) 'queueLength': queueLength,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderWithEstimatedImpl extends OrderWithEstimated {
  _OrderWithEstimatedImpl({
    required _i2.Order order,
    required List<_i3.OrderItem> orderItems,
    int? estimatedPrepTime,
    int? queueLength,
  }) : super._(
         order: order,
         orderItems: orderItems,
         estimatedPrepTime: estimatedPrepTime,
         queueLength: queueLength,
       );

  /// Returns a shallow copy of this [OrderWithEstimated]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderWithEstimated copyWith({
    _i2.Order? order,
    List<_i3.OrderItem>? orderItems,
    Object? estimatedPrepTime = _Undefined,
    Object? queueLength = _Undefined,
  }) {
    return OrderWithEstimated(
      order: order ?? this.order.copyWith(),
      orderItems:
          orderItems ?? this.orderItems.map((e0) => e0.copyWith()).toList(),
      estimatedPrepTime: estimatedPrepTime is int?
          ? estimatedPrepTime
          : this.estimatedPrepTime,
      queueLength: queueLength is int? ? queueLength : this.queueLength,
    );
  }
}
