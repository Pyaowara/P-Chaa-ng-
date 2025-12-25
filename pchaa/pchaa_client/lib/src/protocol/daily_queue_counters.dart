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

abstract class DailyQueueCounter implements _i1.SerializableModel {
  DailyQueueCounter._({
    this.id,
    required this.queueDate,
    required this.iCount,
    required this.sCount,
  });

  factory DailyQueueCounter({
    int? id,
    required DateTime queueDate,
    required int iCount,
    required int sCount,
  }) = _DailyQueueCounterImpl;

  factory DailyQueueCounter.fromJson(Map<String, dynamic> jsonSerialization) {
    return DailyQueueCounter(
      id: jsonSerialization['id'] as int?,
      queueDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['queueDate'],
      ),
      iCount: jsonSerialization['iCount'] as int,
      sCount: jsonSerialization['sCount'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime queueDate;

  int iCount;

  int sCount;

  /// Returns a shallow copy of this [DailyQueueCounter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DailyQueueCounter copyWith({
    int? id,
    DateTime? queueDate,
    int? iCount,
    int? sCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DailyQueueCounter',
      if (id != null) 'id': id,
      'queueDate': queueDate.toJson(),
      'iCount': iCount,
      'sCount': sCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DailyQueueCounterImpl extends DailyQueueCounter {
  _DailyQueueCounterImpl({
    int? id,
    required DateTime queueDate,
    required int iCount,
    required int sCount,
  }) : super._(
         id: id,
         queueDate: queueDate,
         iCount: iCount,
         sCount: sCount,
       );

  /// Returns a shallow copy of this [DailyQueueCounter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DailyQueueCounter copyWith({
    Object? id = _Undefined,
    DateTime? queueDate,
    int? iCount,
    int? sCount,
  }) {
    return DailyQueueCounter(
      id: id is int? ? id : this.id,
      queueDate: queueDate ?? this.queueDate,
      iCount: iCount ?? this.iCount,
      sCount: sCount ?? this.sCount,
    );
  }
}
