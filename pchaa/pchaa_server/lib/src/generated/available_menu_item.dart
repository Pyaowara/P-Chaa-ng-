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
import 'available_customization_group.dart' as _i2;
import 'package:pchaa_server/src/generated/protocol.dart' as _i3;

abstract class AvailableMenuItem
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AvailableMenuItem._({
    this.id,
    required this.name,
    required this.basePrice,
    required this.timeToPrepare,
    required this.customization,
    this.s3Key,
    this.imageUrl,
    required this.isAvailable,
    this.createdAt,
    this.ingredientIds,
    required this.isDeleted,
    required this.forSale,
  });

  factory AvailableMenuItem({
    int? id,
    required String name,
    required double basePrice,
    required int timeToPrepare,
    required List<_i2.AvailableCustomizationGroup> customization,
    String? s3Key,
    String? imageUrl,
    required bool isAvailable,
    DateTime? createdAt,
    List<int>? ingredientIds,
    required bool isDeleted,
    required bool forSale,
  }) = _AvailableMenuItemImpl;

  factory AvailableMenuItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return AvailableMenuItem(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      basePrice: (jsonSerialization['basePrice'] as num).toDouble(),
      timeToPrepare: jsonSerialization['timeToPrepare'] as int,
      customization: _i3.Protocol()
          .deserialize<List<_i2.AvailableCustomizationGroup>>(
            jsonSerialization['customization'],
          ),
      s3Key: jsonSerialization['s3Key'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
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
      forSale: jsonSerialization['forSale'] as bool,
    );
  }

  int? id;

  String name;

  double basePrice;

  int timeToPrepare;

  List<_i2.AvailableCustomizationGroup> customization;

  String? s3Key;

  String? imageUrl;

  bool isAvailable;

  DateTime? createdAt;

  List<int>? ingredientIds;

  bool isDeleted;

  bool forSale;

  /// Returns a shallow copy of this [AvailableMenuItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AvailableMenuItem copyWith({
    int? id,
    String? name,
    double? basePrice,
    int? timeToPrepare,
    List<_i2.AvailableCustomizationGroup>? customization,
    String? s3Key,
    String? imageUrl,
    bool? isAvailable,
    DateTime? createdAt,
    List<int>? ingredientIds,
    bool? isDeleted,
    bool? forSale,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AvailableMenuItem',
      if (id != null) 'id': id,
      'name': name,
      'basePrice': basePrice,
      'timeToPrepare': timeToPrepare,
      'customization': customization.toJson(valueToJson: (v) => v.toJson()),
      if (s3Key != null) 's3Key': s3Key,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (ingredientIds != null) 'ingredientIds': ingredientIds?.toJson(),
      'isDeleted': isDeleted,
      'forSale': forSale,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AvailableMenuItem',
      if (id != null) 'id': id,
      'name': name,
      'basePrice': basePrice,
      'timeToPrepare': timeToPrepare,
      'customization': customization.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (s3Key != null) 's3Key': s3Key,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (ingredientIds != null) 'ingredientIds': ingredientIds?.toJson(),
      'isDeleted': isDeleted,
      'forSale': forSale,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AvailableMenuItemImpl extends AvailableMenuItem {
  _AvailableMenuItemImpl({
    int? id,
    required String name,
    required double basePrice,
    required int timeToPrepare,
    required List<_i2.AvailableCustomizationGroup> customization,
    String? s3Key,
    String? imageUrl,
    required bool isAvailable,
    DateTime? createdAt,
    List<int>? ingredientIds,
    required bool isDeleted,
    required bool forSale,
  }) : super._(
         id: id,
         name: name,
         basePrice: basePrice,
         timeToPrepare: timeToPrepare,
         customization: customization,
         s3Key: s3Key,
         imageUrl: imageUrl,
         isAvailable: isAvailable,
         createdAt: createdAt,
         ingredientIds: ingredientIds,
         isDeleted: isDeleted,
         forSale: forSale,
       );

  /// Returns a shallow copy of this [AvailableMenuItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AvailableMenuItem copyWith({
    Object? id = _Undefined,
    String? name,
    double? basePrice,
    int? timeToPrepare,
    List<_i2.AvailableCustomizationGroup>? customization,
    Object? s3Key = _Undefined,
    Object? imageUrl = _Undefined,
    bool? isAvailable,
    Object? createdAt = _Undefined,
    Object? ingredientIds = _Undefined,
    bool? isDeleted,
    bool? forSale,
  }) {
    return AvailableMenuItem(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      basePrice: basePrice ?? this.basePrice,
      timeToPrepare: timeToPrepare ?? this.timeToPrepare,
      customization:
          customization ??
          this.customization.map((e0) => e0.copyWith()).toList(),
      s3Key: s3Key is String? ? s3Key : this.s3Key,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      ingredientIds: ingredientIds is List<int>?
          ? ingredientIds
          : this.ingredientIds?.map((e0) => e0).toList(),
      isDeleted: isDeleted ?? this.isDeleted,
      forSale: forSale ?? this.forSale,
    );
  }
}
