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
import 'order_status.dart' as _i2;
import 'order_type.dart' as _i3;

abstract class Order implements _i1.SerializableModel {
  Order._({
    this.id,
    required this.userId,
    required this.status,
    required this.type,
    this.pickupTime,
    this.queueNumber,
    this.replyMessage,
    required this.totalOrderPrice,
    required this.orderDate,
    this.createdAt,
  });

  factory Order({
    int? id,
    required int userId,
    required _i2.OrderStatus status,
    required _i3.OrderType type,
    DateTime? pickupTime,
    String? queueNumber,
    String? replyMessage,
    required double totalOrderPrice,
    required DateTime orderDate,
    DateTime? createdAt,
  }) = _OrderImpl;

  factory Order.fromJson(Map<String, dynamic> jsonSerialization) {
    return Order(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      status: _i2.OrderStatus.fromJson((jsonSerialization['status'] as String)),
      type: _i3.OrderType.fromJson((jsonSerialization['type'] as String)),
      pickupTime: jsonSerialization['pickupTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['pickupTime']),
      queueNumber: jsonSerialization['queueNumber'] as String?,
      replyMessage: jsonSerialization['replyMessage'] as String?,
      totalOrderPrice: (jsonSerialization['totalOrderPrice'] as num).toDouble(),
      orderDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['orderDate'],
      ),
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

  _i2.OrderStatus status;

  _i3.OrderType type;

  DateTime? pickupTime;

  String? queueNumber;

  String? replyMessage;

  double totalOrderPrice;

  DateTime orderDate;

  DateTime? createdAt;

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Order copyWith({
    int? id,
    int? userId,
    _i2.OrderStatus? status,
    _i3.OrderType? type,
    DateTime? pickupTime,
    String? queueNumber,
    String? replyMessage,
    double? totalOrderPrice,
    DateTime? orderDate,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Order',
      if (id != null) 'id': id,
      'userId': userId,
      'status': status.toJson(),
      'type': type.toJson(),
      if (pickupTime != null) 'pickupTime': pickupTime?.toJson(),
      if (queueNumber != null) 'queueNumber': queueNumber,
      if (replyMessage != null) 'replyMessage': replyMessage,
      'totalOrderPrice': totalOrderPrice,
      'orderDate': orderDate.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderImpl extends Order {
  _OrderImpl({
    int? id,
    required int userId,
    required _i2.OrderStatus status,
    required _i3.OrderType type,
    DateTime? pickupTime,
    String? queueNumber,
    String? replyMessage,
    required double totalOrderPrice,
    required DateTime orderDate,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         status: status,
         type: type,
         pickupTime: pickupTime,
         queueNumber: queueNumber,
         replyMessage: replyMessage,
         totalOrderPrice: totalOrderPrice,
         orderDate: orderDate,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Order copyWith({
    Object? id = _Undefined,
    int? userId,
    _i2.OrderStatus? status,
    _i3.OrderType? type,
    Object? pickupTime = _Undefined,
    Object? queueNumber = _Undefined,
    Object? replyMessage = _Undefined,
    double? totalOrderPrice,
    DateTime? orderDate,
    Object? createdAt = _Undefined,
  }) {
    return Order(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      type: type ?? this.type,
      pickupTime: pickupTime is DateTime? ? pickupTime : this.pickupTime,
      queueNumber: queueNumber is String? ? queueNumber : this.queueNumber,
      replyMessage: replyMessage is String? ? replyMessage : this.replyMessage,
      totalOrderPrice: totalOrderPrice ?? this.totalOrderPrice,
      orderDate: orderDate ?? this.orderDate,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}
