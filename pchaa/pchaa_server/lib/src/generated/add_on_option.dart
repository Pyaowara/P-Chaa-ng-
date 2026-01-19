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

abstract class AddOnOption
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AddOnOption._({
    required this.name,
    required this.price,
    required this.isAvailable,
    this.ingredientIds,
  });

  factory AddOnOption({
    required String name,
    required double price,
    required bool isAvailable,
    List<int>? ingredientIds,
  }) = _AddOnOptionImpl;

  factory AddOnOption.fromJson(Map<String, dynamic> jsonSerialization) {
    return AddOnOption(
      name: jsonSerialization['name'] as String,
      price: (jsonSerialization['price'] as num).toDouble(),
      isAvailable: jsonSerialization['isAvailable'] as bool,
      ingredientIds: jsonSerialization['ingredientIds'] == null
          ? null
          : _i2.Protocol().deserialize<List<int>>(
              jsonSerialization['ingredientIds'],
            ),
    );
  }

  String name;

  double price;

  bool isAvailable;

  List<int>? ingredientIds;

  /// Returns a shallow copy of this [AddOnOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AddOnOption copyWith({
    String? name,
    double? price,
    bool? isAvailable,
    List<int>? ingredientIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AddOnOption',
      'name': name,
      'price': price,
      'isAvailable': isAvailable,
      if (ingredientIds != null) 'ingredientIds': ingredientIds?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AddOnOption',
      'name': name,
      'price': price,
      'isAvailable': isAvailable,
      if (ingredientIds != null) 'ingredientIds': ingredientIds?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AddOnOptionImpl extends AddOnOption {
  _AddOnOptionImpl({
    required String name,
    required double price,
    required bool isAvailable,
    List<int>? ingredientIds,
  }) : super._(
         name: name,
         price: price,
         isAvailable: isAvailable,
         ingredientIds: ingredientIds,
       );

  /// Returns a shallow copy of this [AddOnOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AddOnOption copyWith({
    String? name,
    double? price,
    bool? isAvailable,
    Object? ingredientIds = _Undefined,
  }) {
    return AddOnOption(
      name: name ?? this.name,
      price: price ?? this.price,
      isAvailable: isAvailable ?? this.isAvailable,
      ingredientIds: ingredientIds is List<int>?
          ? ingredientIds
          : this.ingredientIds?.map((e0) => e0).toList(),
    );
  }
}
