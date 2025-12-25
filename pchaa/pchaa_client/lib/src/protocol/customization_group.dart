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
import 'add_on_option.dart' as _i2;
import 'package:pchaa_client/src/protocol/protocol.dart' as _i3;

abstract class CustomizationGroup implements _i1.SerializableModel {
  CustomizationGroup._({
    required this.title,
    required this.pickOne,
    required this.choices,
  });

  factory CustomizationGroup({
    required String title,
    required bool pickOne,
    required List<_i2.AddOnOption> choices,
  }) = _CustomizationGroupImpl;

  factory CustomizationGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomizationGroup(
      title: jsonSerialization['title'] as String,
      pickOne: jsonSerialization['pickOne'] as bool,
      choices: _i3.Protocol().deserialize<List<_i2.AddOnOption>>(
        jsonSerialization['choices'],
      ),
    );
  }

  String title;

  bool pickOne;

  List<_i2.AddOnOption> choices;

  /// Returns a shallow copy of this [CustomizationGroup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CustomizationGroup copyWith({
    String? title,
    bool? pickOne,
    List<_i2.AddOnOption>? choices,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomizationGroup',
      'title': title,
      'pickOne': pickOne,
      'choices': choices.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CustomizationGroupImpl extends CustomizationGroup {
  _CustomizationGroupImpl({
    required String title,
    required bool pickOne,
    required List<_i2.AddOnOption> choices,
  }) : super._(
         title: title,
         pickOne: pickOne,
         choices: choices,
       );

  /// Returns a shallow copy of this [CustomizationGroup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CustomizationGroup copyWith({
    String? title,
    bool? pickOne,
    List<_i2.AddOnOption>? choices,
  }) {
    return CustomizationGroup(
      title: title ?? this.title,
      pickOne: pickOne ?? this.pickOne,
      choices: choices ?? this.choices.map((e0) => e0.copyWith()).toList(),
    );
  }
}
