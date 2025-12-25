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

abstract class SelectedOption
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SelectedOption._({
    required this.groupTitle,
    required this.name,
    required this.price,
  });

  factory SelectedOption({
    required String groupTitle,
    required String name,
    required double price,
  }) = _SelectedOptionImpl;

  factory SelectedOption.fromJson(Map<String, dynamic> jsonSerialization) {
    return SelectedOption(
      groupTitle: jsonSerialization['groupTitle'] as String,
      name: jsonSerialization['name'] as String,
      price: (jsonSerialization['price'] as num).toDouble(),
    );
  }

  String groupTitle;

  String name;

  double price;

  /// Returns a shallow copy of this [SelectedOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SelectedOption copyWith({
    String? groupTitle,
    String? name,
    double? price,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SelectedOption',
      'groupTitle': groupTitle,
      'name': name,
      'price': price,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SelectedOption',
      'groupTitle': groupTitle,
      'name': name,
      'price': price,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SelectedOptionImpl extends SelectedOption {
  _SelectedOptionImpl({
    required String groupTitle,
    required String name,
    required double price,
  }) : super._(
         groupTitle: groupTitle,
         name: name,
         price: price,
       );

  /// Returns a shallow copy of this [SelectedOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SelectedOption copyWith({
    String? groupTitle,
    String? name,
    double? price,
  }) {
    return SelectedOption(
      groupTitle: groupTitle ?? this.groupTitle,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}
