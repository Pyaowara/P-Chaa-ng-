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
import 'user_role.dart' as _i2;

abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    required this.email,
    required this.fullName,
    this.picture,
    this.phoneNumber,
    required this.role,
    this.createdAt,
  });

  factory User({
    int? id,
    required String email,
    required String fullName,
    String? picture,
    String? phoneNumber,
    required _i2.UserRole role,
    DateTime? createdAt,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      email: jsonSerialization['email'] as String,
      fullName: jsonSerialization['fullName'] as String,
      picture: jsonSerialization['picture'] as String?,
      phoneNumber: jsonSerialization['phoneNumber'] as String?,
      role: _i2.UserRole.fromJson((jsonSerialization['role'] as String)),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String email;

  String fullName;

  String? picture;

  String? phoneNumber;

  _i2.UserRole role;

  DateTime? createdAt;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    String? email,
    String? fullName,
    String? picture,
    String? phoneNumber,
    _i2.UserRole? role,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      'email': email,
      'fullName': fullName,
      if (picture != null) 'picture': picture,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      'role': role.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String email,
    required String fullName,
    String? picture,
    String? phoneNumber,
    required _i2.UserRole role,
    DateTime? createdAt,
  }) : super._(
         id: id,
         email: email,
         fullName: fullName,
         picture: picture,
         phoneNumber: phoneNumber,
         role: role,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    String? email,
    String? fullName,
    Object? picture = _Undefined,
    Object? phoneNumber = _Undefined,
    _i2.UserRole? role,
    Object? createdAt = _Undefined,
  }) {
    return User(
      id: id is int? ? id : this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      picture: picture is String? ? picture : this.picture,
      phoneNumber: phoneNumber is String? ? phoneNumber : this.phoneNumber,
      role: role ?? this.role,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}
