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

abstract class FcmToken
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FcmToken._({
    this.id,
    required this.userId,
    required this.token,
    this.deviceInfo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FcmToken({
    int? id,
    required int userId,
    required String token,
    String? deviceInfo,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FcmTokenImpl;

  factory FcmToken.fromJson(Map<String, dynamic> jsonSerialization) {
    return FcmToken(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      token: jsonSerialization['token'] as String,
      deviceInfo: jsonSerialization['deviceInfo'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = FcmTokenTable();

  static const db = FcmTokenRepository._();

  @override
  int? id;

  int userId;

  String token;

  String? deviceInfo;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FcmToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FcmToken copyWith({
    int? id,
    int? userId,
    String? token,
    String? deviceInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FcmToken',
      if (id != null) 'id': id,
      'userId': userId,
      'token': token,
      if (deviceInfo != null) 'deviceInfo': deviceInfo,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FcmToken',
      if (id != null) 'id': id,
      'userId': userId,
      'token': token,
      if (deviceInfo != null) 'deviceInfo': deviceInfo,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FcmTokenInclude include() {
    return FcmTokenInclude._();
  }

  static FcmTokenIncludeList includeList({
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FcmTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FcmTokenTable>? orderByList,
    FcmTokenInclude? include,
  }) {
    return FcmTokenIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FcmToken.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FcmToken.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FcmTokenImpl extends FcmToken {
  _FcmTokenImpl({
    int? id,
    required int userId,
    required String token,
    String? deviceInfo,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         token: token,
         deviceInfo: deviceInfo,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FcmToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FcmToken copyWith({
    Object? id = _Undefined,
    int? userId,
    String? token,
    Object? deviceInfo = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FcmToken(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      deviceInfo: deviceInfo is String? ? deviceInfo : this.deviceInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FcmTokenUpdateTable extends _i1.UpdateTable<FcmTokenTable> {
  FcmTokenUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> token(String value) => _i1.ColumnValue(
    table.token,
    value,
  );

  _i1.ColumnValue<String, String> deviceInfo(String? value) => _i1.ColumnValue(
    table.deviceInfo,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class FcmTokenTable extends _i1.Table<int?> {
  FcmTokenTable({super.tableRelation}) : super(tableName: 'fcm_tokens') {
    updateTable = FcmTokenUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    token = _i1.ColumnString(
      'token',
      this,
    );
    deviceInfo = _i1.ColumnString(
      'deviceInfo',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final FcmTokenUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString token;

  late final _i1.ColumnString deviceInfo;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    token,
    deviceInfo,
    createdAt,
    updatedAt,
  ];
}

class FcmTokenInclude extends _i1.IncludeObject {
  FcmTokenInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FcmToken.t;
}

class FcmTokenIncludeList extends _i1.IncludeList {
  FcmTokenIncludeList._({
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FcmToken.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FcmToken.t;
}

class FcmTokenRepository {
  const FcmTokenRepository._();

  /// Returns a list of [FcmToken]s matching the given query parameters.
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
  Future<List<FcmToken>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FcmTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FcmTokenTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FcmToken>(
      where: where?.call(FcmToken.t),
      orderBy: orderBy?.call(FcmToken.t),
      orderByList: orderByList?.call(FcmToken.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FcmToken] matching the given query parameters.
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
  Future<FcmToken?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    int? offset,
    _i1.OrderByBuilder<FcmTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FcmTokenTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FcmToken>(
      where: where?.call(FcmToken.t),
      orderBy: orderBy?.call(FcmToken.t),
      orderByList: orderByList?.call(FcmToken.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FcmToken] by its [id] or null if no such row exists.
  Future<FcmToken?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FcmToken>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FcmToken]s in the list and returns the inserted rows.
  ///
  /// The returned [FcmToken]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FcmToken>> insert(
    _i1.Session session,
    List<FcmToken> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FcmToken>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FcmToken] and returns the inserted row.
  ///
  /// The returned [FcmToken] will have its `id` field set.
  Future<FcmToken> insertRow(
    _i1.Session session,
    FcmToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FcmToken>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FcmToken]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FcmToken>> update(
    _i1.Session session,
    List<FcmToken> rows, {
    _i1.ColumnSelections<FcmTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FcmToken>(
      rows,
      columns: columns?.call(FcmToken.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FcmToken]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FcmToken> updateRow(
    _i1.Session session,
    FcmToken row, {
    _i1.ColumnSelections<FcmTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FcmToken>(
      row,
      columns: columns?.call(FcmToken.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FcmToken] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FcmToken?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FcmTokenUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FcmToken>(
      id,
      columnValues: columnValues(FcmToken.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FcmToken]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FcmToken>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FcmTokenUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FcmTokenTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FcmTokenTable>? orderBy,
    _i1.OrderByListBuilder<FcmTokenTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FcmToken>(
      columnValues: columnValues(FcmToken.t.updateTable),
      where: where(FcmToken.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FcmToken.t),
      orderByList: orderByList?.call(FcmToken.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FcmToken]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FcmToken>> delete(
    _i1.Session session,
    List<FcmToken> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FcmToken>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FcmToken].
  Future<FcmToken> deleteRow(
    _i1.Session session,
    FcmToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FcmToken>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FcmToken>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FcmTokenTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FcmToken>(
      where: where(FcmToken.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FcmToken>(
      where: where?.call(FcmToken.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
