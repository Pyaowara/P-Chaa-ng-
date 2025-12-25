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

abstract class AddOnOption implements _i1.SerializableModel {
  AddOnOption._({
    required this.name,
    required this.price,
    required this.isAvailable,
  });

  factory AddOnOption({
    required String name,
    required double price,
    required bool isAvailable,
  }) = _AddOnOptionImpl;

  factory AddOnOption.fromJson(Map<String, dynamic> jsonSerialization) {
    return AddOnOption(
      name: jsonSerialization['name'] as String,
      price: (jsonSerialization['price'] as num).toDouble(),
      isAvailable: jsonSerialization['isAvailable'] as bool,
    );
  }

  String name;

  double price;

  bool isAvailable;

  /// Returns a shallow copy of this [AddOnOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AddOnOption copyWith({
    String? name,
    double? price,
    bool? isAvailable,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AddOnOption',
      'name': name,
      'price': price,
      'isAvailable': isAvailable,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AddOnOptionImpl extends AddOnOption {
  _AddOnOptionImpl({
    required String name,
    required double price,
    required bool isAvailable,
  }) : super._(
         name: name,
         price: price,
         isAvailable: isAvailable,
       );

  /// Returns a shallow copy of this [AddOnOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AddOnOption copyWith({
    String? name,
    double? price,
    bool? isAvailable,
  }) {
    return AddOnOption(
      name: name ?? this.name,
      price: price ?? this.price,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
