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

abstract class DailyQueueCounter
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = DailyQueueCounterTable();

  static const db = DailyQueueCounterRepository._();

  @override
  int? id;

  DateTime queueDate;

  int iCount;

  int sCount;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DailyQueueCounter',
      if (id != null) 'id': id,
      'queueDate': queueDate.toJson(),
      'iCount': iCount,
      'sCount': sCount,
    };
  }

  static DailyQueueCounterInclude include() {
    return DailyQueueCounterInclude._();
  }

  static DailyQueueCounterIncludeList includeList({
    _i1.WhereExpressionBuilder<DailyQueueCounterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DailyQueueCounterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DailyQueueCounterTable>? orderByList,
    DailyQueueCounterInclude? include,
  }) {
    return DailyQueueCounterIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DailyQueueCounter.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DailyQueueCounter.t),
      include: include,
    );
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

class DailyQueueCounterUpdateTable
    extends _i1.UpdateTable<DailyQueueCounterTable> {
  DailyQueueCounterUpdateTable(super.table);

  _i1.ColumnValue<DateTime, DateTime> queueDate(DateTime value) =>
      _i1.ColumnValue(
        table.queueDate,
        value,
      );

  _i1.ColumnValue<int, int> iCount(int value) => _i1.ColumnValue(
    table.iCount,
    value,
  );

  _i1.ColumnValue<int, int> sCount(int value) => _i1.ColumnValue(
    table.sCount,
    value,
  );
}

class DailyQueueCounterTable extends _i1.Table<int?> {
  DailyQueueCounterTable({super.tableRelation})
    : super(tableName: 'daily_queue_counters') {
    updateTable = DailyQueueCounterUpdateTable(this);
    queueDate = _i1.ColumnDateTime(
      'queueDate',
      this,
    );
    iCount = _i1.ColumnInt(
      'iCount',
      this,
    );
    sCount = _i1.ColumnInt(
      'sCount',
      this,
    );
  }

  late final DailyQueueCounterUpdateTable updateTable;

  late final _i1.ColumnDateTime queueDate;

  late final _i1.ColumnInt iCount;

  late final _i1.ColumnInt sCount;

  @override
  List<_i1.Column> get columns => [
    id,
    queueDate,
    iCount,
    sCount,
  ];
}

class DailyQueueCounterInclude extends _i1.IncludeObject {
  DailyQueueCounterInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DailyQueueCounter.t;
}

class DailyQueueCounterIncludeList extends _i1.IncludeList {
  DailyQueueCounterIncludeList._({
    _i1.WhereExpressionBuilder<DailyQueueCounterTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DailyQueueCounter.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DailyQueueCounter.t;
}

class DailyQueueCounterRepository {
  const DailyQueueCounterRepository._();

  /// Returns a list of [DailyQueueCounter]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<DailyQueueCounter>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DailyQueueCounterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DailyQueueCounterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DailyQueueCounterTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DailyQueueCounter>(
      where: where?.call(DailyQueueCounter.t),
      orderBy: orderBy?.call(DailyQueueCounter.t),
      orderByList: orderByList?.call(DailyQueueCounter.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DailyQueueCounter] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<DailyQueueCounter?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DailyQueueCounterTable>? where,
    int? offset,
    _i1.OrderByBuilder<DailyQueueCounterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DailyQueueCounterTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DailyQueueCounter>(
      where: where?.call(DailyQueueCounter.t),
      orderBy: orderBy?.call(DailyQueueCounter.t),
      orderByList: orderByList?.call(DailyQueueCounter.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DailyQueueCounter] by its [id] or null if no such row exists.
  Future<DailyQueueCounter?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DailyQueueCounter>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DailyQueueCounter]s in the list and returns the inserted rows.
  ///
  /// The returned [DailyQueueCounter]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DailyQueueCounter>> insert(
    _i1.Session session,
    List<DailyQueueCounter> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DailyQueueCounter>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DailyQueueCounter] and returns the inserted row.
  ///
  /// The returned [DailyQueueCounter] will have its `id` field set.
  Future<DailyQueueCounter> insertRow(
    _i1.Session session,
    DailyQueueCounter row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DailyQueueCounter>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DailyQueueCounter]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DailyQueueCounter>> update(
    _i1.Session session,
    List<DailyQueueCounter> rows, {
    _i1.ColumnSelections<DailyQueueCounterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DailyQueueCounter>(
      rows,
      columns: columns?.call(DailyQueueCounter.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DailyQueueCounter]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DailyQueueCounter> updateRow(
    _i1.Session session,
    DailyQueueCounter row, {
    _i1.ColumnSelections<DailyQueueCounterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DailyQueueCounter>(
      row,
      columns: columns?.call(DailyQueueCounter.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DailyQueueCounter] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DailyQueueCounter?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DailyQueueCounterUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DailyQueueCounter>(
      id,
      columnValues: columnValues(DailyQueueCounter.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DailyQueueCounter]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DailyQueueCounter>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DailyQueueCounterUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DailyQueueCounterTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DailyQueueCounterTable>? orderBy,
    _i1.OrderByListBuilder<DailyQueueCounterTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DailyQueueCounter>(
      columnValues: columnValues(DailyQueueCounter.t.updateTable),
      where: where(DailyQueueCounter.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DailyQueueCounter.t),
      orderByList: orderByList?.call(DailyQueueCounter.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DailyQueueCounter]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DailyQueueCounter>> delete(
    _i1.Session session,
    List<DailyQueueCounter> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DailyQueueCounter>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DailyQueueCounter].
  Future<DailyQueueCounter> deleteRow(
    _i1.Session session,
    DailyQueueCounter row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DailyQueueCounter>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DailyQueueCounter>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DailyQueueCounterTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DailyQueueCounter>(
      where: where(DailyQueueCounter.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DailyQueueCounterTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DailyQueueCounter>(
      where: where?.call(DailyQueueCounter.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
