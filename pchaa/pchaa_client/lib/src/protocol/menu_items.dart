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
import 'customization_group.dart' as _i2;
import 'package:pchaa_client/src/protocol/protocol.dart' as _i3;

abstract class MenuItem implements _i1.SerializableModel {
  MenuItem._({
    this.id,
    required this.name,
    required this.basePrice,
    required this.timeToPrepare,
    required this.customization,
    this.s3Key,
    required this.isAvailable,
    this.createdAt,
    this.ingredientIds,
    required this.isDeleted,
  });

  factory MenuItem({
    int? id,
    required String name,
    required double basePrice,
    required int timeToPrepare,
    required List<_i2.CustomizationGroup> customization,
    String? s3Key,
    required bool isAvailable,
    DateTime? createdAt,
    List<int>? ingredientIds,
    required bool isDeleted,
  }) = _MenuItemImpl;

  factory MenuItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuItem(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      basePrice: (jsonSerialization['basePrice'] as num).toDouble(),
      timeToPrepare: jsonSerialization['timeToPrepare'] as int,
      customization: _i3.Protocol().deserialize<List<_i2.CustomizationGroup>>(
        jsonSerialization['customization'],
      ),
      s3Key: jsonSerialization['s3Key'] as String?,
      isAvailable: jsonSerialization['isAvailable'] as bool,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      ingredientIds: jsonSerialization['ingredientIds'] == null
          ? null
          : _i3.Protocol().deserialize<List<int>>(
              jsonSerialization['ingredientIds'],
            ),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  double basePrice;

  int timeToPrepare;

  List<_i2.CustomizationGroup> customization;

  String? s3Key;

  bool isAvailable;

  DateTime? createdAt;

  List<int>? ingredientIds;

  bool isDeleted;

  /// Returns a shallow copy of this [MenuItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MenuItem copyWith({
    int? id,
    String? name,
    double? basePrice,
    int? timeToPrepare,
    List<_i2.CustomizationGroup>? customization,
    String? s3Key,
    bool? isAvailable,
    DateTime? createdAt,
    List<int>? ingredientIds,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuItem',
      if (id != null) 'id': id,
      'name': name,
      'basePrice': basePrice,
      'timeToPrepare': timeToPrepare,
      'customization': customization.toJson(valueToJson: (v) => v.toJson()),
      if (s3Key != null) 's3Key': s3Key,
      'isAvailable': isAvailable,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (ingredientIds != null) 'ingredientIds': ingredientIds?.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuItemImpl extends MenuItem {
  _MenuItemImpl({
    int? id,
    required String name,
    required double basePrice,
    required int timeToPrepare,
    required List<_i2.CustomizationGroup> customization,
    String? s3Key,
    required bool isAvailable,
    DateTime? createdAt,
    List<int>? ingredientIds,
    required bool isDeleted,
  }) : super._(
         id: id,
         name: name,
         basePrice: basePrice,
         timeToPrepare: timeToPrepare,
         customization: customization,
         s3Key: s3Key,
         isAvailable: isAvailable,
         createdAt: createdAt,
         ingredientIds: ingredientIds,
         isDeleted: isDeleted,
       );

  /// Returns a shallow copy of this [MenuItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MenuItem copyWith({
    Object? id = _Undefined,
    String? name,
    double? basePrice,
    int? timeToPrepare,
    List<_i2.CustomizationGroup>? customization,
    Object? s3Key = _Undefined,
    bool? isAvailable,
    Object? createdAt = _Undefined,
    Object? ingredientIds = _Undefined,
    bool? isDeleted,
  }) {
    return MenuItem(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      basePrice: basePrice ?? this.basePrice,
      timeToPrepare: timeToPrepare ?? this.timeToPrepare,
      customization:
          customization ??
          this.customization.map((e0) => e0.copyWith()).toList(),
      s3Key: s3Key is String? ? s3Key : this.s3Key,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      ingredientIds: ingredientIds is List<int>?
          ? ingredientIds
          : this.ingredientIds?.map((e0) => e0).toList(),
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
