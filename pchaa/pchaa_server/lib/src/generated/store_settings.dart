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

abstract class StoreSettings
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StoreSettings._({
    this.id,
    required this.isOpen,
    required this.openTime,
    required this.closeTime,
    required this.autoOpenClose,
    this.s3Key,
  });

  factory StoreSettings({
    int? id,
    required bool isOpen,
    required String openTime,
    required String closeTime,
    required bool autoOpenClose,
    String? s3Key,
  }) = _StoreSettingsImpl;

  factory StoreSettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreSettings(
      id: jsonSerialization['id'] as int?,
      isOpen: jsonSerialization['isOpen'] as bool,
      openTime: jsonSerialization['openTime'] as String,
      closeTime: jsonSerialization['closeTime'] as String,
      autoOpenClose: jsonSerialization['autoOpenClose'] as bool,
      s3Key: jsonSerialization['s3Key'] as String?,
    );
  }

  static final t = StoreSettingsTable();

  static const db = StoreSettingsRepository._();

  @override
  int? id;

  bool isOpen;

  String openTime;

  String closeTime;

  bool autoOpenClose;

  String? s3Key;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreSettings copyWith({
    int? id,
    bool? isOpen,
    String? openTime,
    String? closeTime,
    bool? autoOpenClose,
    String? s3Key,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreSettings',
      if (id != null) 'id': id,
      'isOpen': isOpen,
      'openTime': openTime,
      'closeTime': closeTime,
      'autoOpenClose': autoOpenClose,
      if (s3Key != null) 's3Key': s3Key,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StoreSettings',
      if (id != null) 'id': id,
      'isOpen': isOpen,
      'openTime': openTime,
      'closeTime': closeTime,
      'autoOpenClose': autoOpenClose,
      if (s3Key != null) 's3Key': s3Key,
    };
  }

  static StoreSettingsInclude include() {
    return StoreSettingsInclude._();
  }

  static StoreSettingsIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreSettingsTable>? orderByList,
    StoreSettingsInclude? include,
  }) {
    return StoreSettingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreSettings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreSettings.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreSettingsImpl extends StoreSettings {
  _StoreSettingsImpl({
    int? id,
    required bool isOpen,
    required String openTime,
    required String closeTime,
    required bool autoOpenClose,
    String? s3Key,
  }) : super._(
         id: id,
         isOpen: isOpen,
         openTime: openTime,
         closeTime: closeTime,
         autoOpenClose: autoOpenClose,
         s3Key: s3Key,
       );

  /// Returns a shallow copy of this [StoreSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreSettings copyWith({
    Object? id = _Undefined,
    bool? isOpen,
    String? openTime,
    String? closeTime,
    bool? autoOpenClose,
    Object? s3Key = _Undefined,
  }) {
    return StoreSettings(
      id: id is int? ? id : this.id,
      isOpen: isOpen ?? this.isOpen,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      autoOpenClose: autoOpenClose ?? this.autoOpenClose,
      s3Key: s3Key is String? ? s3Key : this.s3Key,
    );
  }
}

class StoreSettingsUpdateTable extends _i1.UpdateTable<StoreSettingsTable> {
  StoreSettingsUpdateTable(super.table);

  _i1.ColumnValue<bool, bool> isOpen(bool value) => _i1.ColumnValue(
    table.isOpen,
    value,
  );

  _i1.ColumnValue<String, String> openTime(String value) => _i1.ColumnValue(
    table.openTime,
    value,
  );

  _i1.ColumnValue<String, String> closeTime(String value) => _i1.ColumnValue(
    table.closeTime,
    value,
  );

  _i1.ColumnValue<bool, bool> autoOpenClose(bool value) => _i1.ColumnValue(
    table.autoOpenClose,
    value,
  );

  _i1.ColumnValue<String, String> s3Key(String? value) => _i1.ColumnValue(
    table.s3Key,
    value,
  );
}

class StoreSettingsTable extends _i1.Table<int?> {
  StoreSettingsTable({super.tableRelation})
    : super(tableName: 'store_settings') {
    updateTable = StoreSettingsUpdateTable(this);
    isOpen = _i1.ColumnBool(
      'isOpen',
      this,
    );
    openTime = _i1.ColumnString(
      'openTime',
      this,
    );
    closeTime = _i1.ColumnString(
      'closeTime',
      this,
    );
    autoOpenClose = _i1.ColumnBool(
      'autoOpenClose',
      this,
    );
    s3Key = _i1.ColumnString(
      's3Key',
      this,
    );
  }

  late final StoreSettingsUpdateTable updateTable;

  late final _i1.ColumnBool isOpen;

  late final _i1.ColumnString openTime;

  late final _i1.ColumnString closeTime;

  late final _i1.ColumnBool autoOpenClose;

  late final _i1.ColumnString s3Key;

  @override
  List<_i1.Column> get columns => [
    id,
    isOpen,
    openTime,
    closeTime,
    autoOpenClose,
    s3Key,
  ];
}

class StoreSettingsInclude extends _i1.IncludeObject {
  StoreSettingsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StoreSettings.t;
}

class StoreSettingsIncludeList extends _i1.IncludeList {
  StoreSettingsIncludeList._({
    _i1.WhereExpressionBuilder<StoreSettingsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreSettings.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StoreSettings.t;
}

class StoreSettingsRepository {
  const StoreSettingsRepository._();

  /// Returns a list of [StoreSettings]s matching the given query parameters.
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
  Future<List<StoreSettings>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreSettingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreSettings>(
      where: where?.call(StoreSettings.t),
      orderBy: orderBy?.call(StoreSettings.t),
      orderByList: orderByList?.call(StoreSettings.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StoreSettings] matching the given query parameters.
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
  Future<StoreSettings?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreSettingsTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreSettingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreSettings>(
      where: where?.call(StoreSettings.t),
      orderBy: orderBy?.call(StoreSettings.t),
      orderByList: orderByList?.call(StoreSettings.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StoreSettings] by its [id] or null if no such row exists.
  Future<StoreSettings?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreSettings>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StoreSettings]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreSettings]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StoreSettings>> insert(
    _i1.Session session,
    List<StoreSettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreSettings>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StoreSettings] and returns the inserted row.
  ///
  /// The returned [StoreSettings] will have its `id` field set.
  Future<StoreSettings> insertRow(
    _i1.Session session,
    StoreSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreSettings>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreSettings]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreSettings>> update(
    _i1.Session session,
    List<StoreSettings> rows, {
    _i1.ColumnSelections<StoreSettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreSettings>(
      rows,
      columns: columns?.call(StoreSettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreSettings]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreSettings> updateRow(
    _i1.Session session,
    StoreSettings row, {
    _i1.ColumnSelections<StoreSettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreSettings>(
      row,
      columns: columns?.call(StoreSettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreSettings] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreSettings?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreSettingsUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreSettings>(
      id,
      columnValues: columnValues(StoreSettings.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreSettings]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StoreSettings>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StoreSettingsUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StoreSettingsTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreSettingsTable>? orderBy,
    _i1.OrderByListBuilder<StoreSettingsTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StoreSettings>(
      columnValues: columnValues(StoreSettings.t.updateTable),
      where: where(StoreSettings.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreSettings.t),
      orderByList: orderByList?.call(StoreSettings.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StoreSettings]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreSettings>> delete(
    _i1.Session session,
    List<StoreSettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreSettings>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreSettings].
  Future<StoreSettings> deleteRow(
    _i1.Session session,
    StoreSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreSettings>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreSettings>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreSettingsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreSettings>(
      where: where(StoreSettings.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreSettingsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreSettings>(
      where: where?.call(StoreSettings.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
