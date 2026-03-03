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

abstract class FcmToken implements _i1.SerializableModel {
  FcmToken._({
    this.id,
    required this.userId,
    required this.token,
    this.deviceInfo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FcmToken({
    int? id,
    required int userId,
    required String token,
    String? deviceInfo,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FcmTokenImpl;

  factory FcmToken.fromJson(Map<String, dynamic> jsonSerialization) {
    return FcmToken(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      token: jsonSerialization['token'] as String,
      deviceInfo: jsonSerialization['deviceInfo'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String token;

  String? deviceInfo;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [FcmToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FcmToken copyWith({
    int? id,
    int? userId,
    String? token,
    String? deviceInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FcmToken',
      if (id != null) 'id': id,
      'userId': userId,
      'token': token,
      if (deviceInfo != null) 'deviceInfo': deviceInfo,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FcmTokenImpl extends FcmToken {
  _FcmTokenImpl({
    int? id,
    required int userId,
    required String token,
    String? deviceInfo,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         token: token,
         deviceInfo: deviceInfo,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FcmToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FcmToken copyWith({
    Object? id = _Undefined,
    int? userId,
    String? token,
    Object? deviceInfo = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FcmToken(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      deviceInfo: deviceInfo is String? ? deviceInfo : this.deviceInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
