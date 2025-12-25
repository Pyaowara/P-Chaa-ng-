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

abstract class StoreSettings implements _i1.SerializableModel {
  StoreSettings._({
    this.id,
    required this.isOpen,
    required this.openTime,
    required this.closeTime,
    required this.autoOpenClose,
    this.s3Key,
  });

  factory StoreSettings({
    int? id,
    required bool isOpen,
    required String openTime,
    required String closeTime,
    required bool autoOpenClose,
    String? s3Key,
  }) = _StoreSettingsImpl;

  factory StoreSettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreSettings(
      id: jsonSerialization['id'] as int?,
      isOpen: jsonSerialization['isOpen'] as bool,
      openTime: jsonSerialization['openTime'] as String,
      closeTime: jsonSerialization['closeTime'] as String,
      autoOpenClose: jsonSerialization['autoOpenClose'] as bool,
      s3Key: jsonSerialization['s3Key'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  bool isOpen;

  String openTime;

  String closeTime;

  bool autoOpenClose;

  String? s3Key;

  /// Returns a shallow copy of this [StoreSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreSettings copyWith({
    int? id,
    bool? isOpen,
    String? openTime,
    String? closeTime,
    bool? autoOpenClose,
    String? s3Key,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreSettings',
      if (id != null) 'id': id,
      'isOpen': isOpen,
      'openTime': openTime,
      'closeTime': closeTime,
      'autoOpenClose': autoOpenClose,
      if (s3Key != null) 's3Key': s3Key,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreSettingsImpl extends StoreSettings {
  _StoreSettingsImpl({
    int? id,
    required bool isOpen,
    required String openTime,
    required String closeTime,
    required bool autoOpenClose,
    String? s3Key,
  }) : super._(
         id: id,
         isOpen: isOpen,
         openTime: openTime,
         closeTime: closeTime,
         autoOpenClose: autoOpenClose,
         s3Key: s3Key,
       );

  /// Returns a shallow copy of this [StoreSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreSettings copyWith({
    Object? id = _Undefined,
    bool? isOpen,
    String? openTime,
    String? closeTime,
    bool? autoOpenClose,
    Object? s3Key = _Undefined,
  }) {
    return StoreSettings(
      id: id is int? ? id : this.id,
      isOpen: isOpen ?? this.isOpen,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      autoOpenClose: autoOpenClose ?? this.autoOpenClose,
      s3Key: s3Key is String? ? s3Key : this.s3Key,
    );
  }
}
