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
import 'package:pchaa_server/src/generated/protocol.dart' as _i3;

abstract class OrderWithUserName
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  OrderWithUserName._({
    required this.order,
    required this.userName,
  });

  factory OrderWithUserName({
    required _i2.Order order,
    required String userName,
  }) = _OrderWithUserNameImpl;

  factory OrderWithUserName.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderWithUserName(
      order: _i3.Protocol().deserialize<_i2.Order>(jsonSerialization['order']),
      userName: jsonSerialization['userName'] as String,
    );
  }

  _i2.Order order;

  String userName;

  /// Returns a shallow copy of this [OrderWithUserName]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderWithUserName copyWith({
    _i2.Order? order,
    String? userName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderWithUserName',
      'order': order.toJson(),
      'userName': userName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderWithUserName',
      'order': order.toJsonForProtocol(),
      'userName': userName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OrderWithUserNameImpl extends OrderWithUserName {
  _OrderWithUserNameImpl({
    required _i2.Order order,
    required String userName,
  }) : super._(
         order: order,
         userName: userName,
       );

  /// Returns a shallow copy of this [OrderWithUserName]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderWithUserName copyWith({
    _i2.Order? order,
    String? userName,
  }) {
    return OrderWithUserName(
      order: order ?? this.order.copyWith(),
      userName: userName ?? this.userName,
    );
  }
}
