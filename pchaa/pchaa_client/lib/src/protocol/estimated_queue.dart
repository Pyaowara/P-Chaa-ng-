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

abstract class EstimatedQueue implements _i1.SerializableModel {
  EstimatedQueue._({
    required this.estimatedPrepTime,
    required this.queueLength,
  });

  factory EstimatedQueue({
    required int estimatedPrepTime,
    required int queueLength,
  }) = _EstimatedQueueImpl;

  factory EstimatedQueue.fromJson(Map<String, dynamic> jsonSerialization) {
    return EstimatedQueue(
      estimatedPrepTime: jsonSerialization['estimatedPrepTime'] as int,
      queueLength: jsonSerialization['queueLength'] as int,
    );
  }

  int estimatedPrepTime;

  int queueLength;

  /// Returns a shallow copy of this [EstimatedQueue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EstimatedQueue copyWith({
    int? estimatedPrepTime,
    int? queueLength,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EstimatedQueue',
      'estimatedPrepTime': estimatedPrepTime,
      'queueLength': queueLength,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EstimatedQueueImpl extends EstimatedQueue {
  _EstimatedQueueImpl({
    required int estimatedPrepTime,
    required int queueLength,
  }) : super._(
         estimatedPrepTime: estimatedPrepTime,
         queueLength: queueLength,
       );

  /// Returns a shallow copy of this [EstimatedQueue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EstimatedQueue copyWith({
    int? estimatedPrepTime,
    int? queueLength,
  }) {
    return EstimatedQueue(
      estimatedPrepTime: estimatedPrepTime ?? this.estimatedPrepTime,
      queueLength: queueLength ?? this.queueLength,
    );
  }
}
