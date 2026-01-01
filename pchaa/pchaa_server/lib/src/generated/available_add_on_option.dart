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
import 'package:pchaa_server/src/generated/protocol.dart' as _i2;

abstract class AvailableAddOnOption
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AvailableAddOnOption._({
    required this.name,
    required this.price,
    required this.isAvailable,
    this.ingredientIds,
    required this.forSale,
  });

  factory AvailableAddOnOption({
    required String name,
    required double price,
    required bool isAvailable,
    List<int>? ingredientIds,
    required bool forSale,
  }) = _AvailableAddOnOptionImpl;

  factory AvailableAddOnOption.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AvailableAddOnOption(
      name: jsonSerialization['name'] as String,
      price: (jsonSerialization['price'] as num).toDouble(),
      isAvailable: jsonSerialization['isAvailable'] as bool,
      ingredientIds: jsonSerialization['ingredientIds'] == null
          ? null
          : _i2.Protocol().deserialize<List<int>>(
              jsonSerialization['ingredientIds'],
            ),
      forSale: jsonSerialization['forSale'] as bool,
    );
  }

  String name;

  double price;

  bool isAvailable;

  List<int>? ingredientIds;

  bool forSale;

  /// Returns a shallow copy of this [AvailableAddOnOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AvailableAddOnOption copyWith({
    String? name,
    double? price,
    bool? isAvailable,
    List<int>? ingredientIds,
    bool? forSale,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AvailableAddOnOption',
      'name': name,
      'price': price,
      'isAvailable': isAvailable,
      if (ingredientIds != null) 'ingredientIds': ingredientIds?.toJson(),
      'forSale': forSale,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AvailableAddOnOption',
      'name': name,
      'price': price,
      'isAvailable': isAvailable,
      if (ingredientIds != null) 'ingredientIds': ingredientIds?.toJson(),
      'forSale': forSale,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AvailableAddOnOptionImpl extends AvailableAddOnOption {
  _AvailableAddOnOptionImpl({
    required String name,
    required double price,
    required bool isAvailable,
    List<int>? ingredientIds,
    required bool forSale,
  }) : super._(
         name: name,
         price: price,
         isAvailable: isAvailable,
         ingredientIds: ingredientIds,
         forSale: forSale,
       );

  /// Returns a shallow copy of this [AvailableAddOnOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AvailableAddOnOption copyWith({
    String? name,
    double? price,
    bool? isAvailable,
    Object? ingredientIds = _Undefined,
    bool? forSale,
  }) {
    return AvailableAddOnOption(
      name: name ?? this.name,
      price: price ?? this.price,
      isAvailable: isAvailable ?? this.isAvailable,
      ingredientIds: ingredientIds is List<int>?
          ? ingredientIds
          : this.ingredientIds?.map((e0) => e0).toList(),
      forSale: forSale ?? this.forSale,
    );
  }
}
