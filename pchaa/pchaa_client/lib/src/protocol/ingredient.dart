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

abstract class Ingredient implements _i1.SerializableModel {
  Ingredient._({
    this.id,
    required this.name,
    required this.isAvailable,
    required this.isDeleted,
  });

  factory Ingredient({
    int? id,
    required String name,
    required bool isAvailable,
    required bool isDeleted,
  }) = _IngredientImpl;

  factory Ingredient.fromJson(Map<String, dynamic> jsonSerialization) {
    return Ingredient(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      isAvailable: jsonSerialization['isAvailable'] as bool,
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  bool isAvailable;

  bool isDeleted;

  /// Returns a shallow copy of this [Ingredient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Ingredient copyWith({
    int? id,
    String? name,
    bool? isAvailable,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Ingredient',
      if (id != null) 'id': id,
      'name': name,
      'isAvailable': isAvailable,
      'isDeleted': isDeleted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IngredientImpl extends Ingredient {
  _IngredientImpl({
    int? id,
    required String name,
    required bool isAvailable,
    required bool isDeleted,
  }) : super._(
         id: id,
         name: name,
         isAvailable: isAvailable,
         isDeleted: isDeleted,
       );

  /// Returns a shallow copy of this [Ingredient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Ingredient copyWith({
    Object? id = _Undefined,
    String? name,
    bool? isAvailable,
    bool? isDeleted,
  }) {
    return Ingredient(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      isAvailable: isAvailable ?? this.isAvailable,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
