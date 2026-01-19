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
import 'customization_group.dart' as _i2;
import 'package:pchaa_server/src/generated/protocol.dart' as _i3;

abstract class MenuItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MenuItem._({
    this.id,
    required this.name,
    required this.basePrice,
    required this.timeToPrepare,
    required this.customization,
    this.s3Key,
    required this.isAvailable,
    this.createdAt,
    this.ingredientIds,
    required this.isDeleted,
  });

  factory MenuItem({
    int? id,
    required String name,
    required double basePrice,
    required int timeToPrepare,
    required List<_i2.CustomizationGroup> customization,
    String? s3Key,
    required bool isAvailable,
    DateTime? createdAt,
    List<int>? ingredientIds,
    required bool isDeleted,
  }) = _MenuItemImpl;

  factory MenuItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuItem(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      basePrice: (jsonSerialization['basePrice'] as num).toDouble(),
      timeToPrepare: jsonSerialization['timeToPrepare'] as int,
      customization: _i3.Protocol().deserialize<List<_i2.CustomizationGroup>>(
        jsonSerialization['customization'],
      ),
      s3Key: jsonSerialization['s3Key'] as String?,
      isAvailable: jsonSerialization['isAvailable'] as bool,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      ingredientIds: jsonSerialization['ingredientIds'] == null
          ? null
          : _i3.Protocol().deserialize<List<int>>(
              jsonSerialization['ingredientIds'],
            ),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = MenuItemTable();

  static const db = MenuItemRepository._();

  @override
  int? id;

  String name;

  double basePrice;

  int timeToPrepare;

  List<_i2.CustomizationGroup> customization;

  String? s3Key;

  bool isAvailable;

  DateTime? createdAt;

  List<int>? ingredientIds;

  bool isDeleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MenuItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MenuItem copyWith({
    int? id,
    String? name,
    double? basePrice,
    int? timeToPrepare,
    List<_i2.CustomizationGroup>? customization,
    String? s3Key,
    bool? isAvailable,
    DateTime? createdAt,
    List<int>? ingredientIds,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuItem',
      if (id != null) 'id': id,
      'name': name,
      'basePrice': basePrice,
      'timeToPrepare': timeToPrepare,
      'customization': customization.toJson(valueToJson: (v) => v.toJson()),
      if (s3Key != null) 's3Key': s3Key,
      'isAvailable': isAvailable,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (ingredientIds != null) 'ingredientIds': ingredientIds?.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MenuItem',
      if (id != null) 'id': id,
      'name': name,
      'basePrice': basePrice,
      'timeToPrepare': timeToPrepare,
      'customization': customization.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (s3Key != null) 's3Key': s3Key,
      'isAvailable': isAvailable,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (ingredientIds != null) 'ingredientIds': ingredientIds?.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static MenuItemInclude include() {
    return MenuItemInclude._();
  }

  static MenuItemIncludeList includeList({
    _i1.WhereExpressionBuilder<MenuItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MenuItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuItemTable>? orderByList,
    MenuItemInclude? include,
  }) {
    return MenuItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MenuItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MenuItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuItemImpl extends MenuItem {
  _MenuItemImpl({
    int? id,
    required String name,
    required double basePrice,
    required int timeToPrepare,
    required List<_i2.CustomizationGroup> customization,
    String? s3Key,
    required bool isAvailable,
    DateTime? createdAt,
    List<int>? ingredientIds,
    required bool isDeleted,
  }) : super._(
         id: id,
         name: name,
         basePrice: basePrice,
         timeToPrepare: timeToPrepare,
         customization: customization,
         s3Key: s3Key,
         isAvailable: isAvailable,
         createdAt: createdAt,
         ingredientIds: ingredientIds,
         isDeleted: isDeleted,
       );

  /// Returns a shallow copy of this [MenuItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MenuItem copyWith({
    Object? id = _Undefined,
    String? name,
    double? basePrice,
    int? timeToPrepare,
    List<_i2.CustomizationGroup>? customization,
    Object? s3Key = _Undefined,
    bool? isAvailable,
    Object? createdAt = _Undefined,
    Object? ingredientIds = _Undefined,
    bool? isDeleted,
  }) {
    return MenuItem(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      basePrice: basePrice ?? this.basePrice,
      timeToPrepare: timeToPrepare ?? this.timeToPrepare,
      customization:
          customization ??
          this.customization.map((e0) => e0.copyWith()).toList(),
      s3Key: s3Key is String? ? s3Key : this.s3Key,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      ingredientIds: ingredientIds is List<int>?
          ? ingredientIds
          : this.ingredientIds?.map((e0) => e0).toList(),
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class MenuItemUpdateTable extends _i1.UpdateTable<MenuItemTable> {
  MenuItemUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<double, double> basePrice(double value) => _i1.ColumnValue(
    table.basePrice,
    value,
  );

  _i1.ColumnValue<int, int> timeToPrepare(int value) => _i1.ColumnValue(
    table.timeToPrepare,
    value,
  );

  _i1.ColumnValue<List<_i2.CustomizationGroup>, List<_i2.CustomizationGroup>>
  customization(List<_i2.CustomizationGroup> value) => _i1.ColumnValue(
    table.customization,
    value,
  );

  _i1.ColumnValue<String, String> s3Key(String? value) => _i1.ColumnValue(
    table.s3Key,
    value,
  );

  _i1.ColumnValue<bool, bool> isAvailable(bool value) => _i1.ColumnValue(
    table.isAvailable,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<List<int>, List<int>> ingredientIds(List<int>? value) =>
      _i1.ColumnValue(
        table.ingredientIds,
        value,
      );

  _i1.ColumnValue<bool, bool> isDeleted(bool value) => _i1.ColumnValue(
    table.isDeleted,
    value,
  );
}

class MenuItemTable extends _i1.Table<int?> {
  MenuItemTable({super.tableRelation}) : super(tableName: 'menu_items') {
    updateTable = MenuItemUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    basePrice = _i1.ColumnDouble(
      'basePrice',
      this,
    );
    timeToPrepare = _i1.ColumnInt(
      'timeToPrepare',
      this,
    );
    customization = _i1.ColumnSerializable<List<_i2.CustomizationGroup>>(
      'customization',
      this,
    );
    s3Key = _i1.ColumnString(
      's3Key',
      this,
    );
    isAvailable = _i1.ColumnBool(
      'isAvailable',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    ingredientIds = _i1.ColumnSerializable<List<int>>(
      'ingredientIds',
      this,
    );
    isDeleted = _i1.ColumnBool(
      'isDeleted',
      this,
    );
  }

  late final MenuItemUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnDouble basePrice;

  late final _i1.ColumnInt timeToPrepare;

  late final _i1.ColumnSerializable<List<_i2.CustomizationGroup>> customization;

  late final _i1.ColumnString s3Key;

  late final _i1.ColumnBool isAvailable;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnSerializable<List<int>> ingredientIds;

  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    basePrice,
    timeToPrepare,
    customization,
    s3Key,
    isAvailable,
    createdAt,
    ingredientIds,
    isDeleted,
  ];
}

class MenuItemInclude extends _i1.IncludeObject {
  MenuItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MenuItem.t;
}

class MenuItemIncludeList extends _i1.IncludeList {
  MenuItemIncludeList._({
    _i1.WhereExpressionBuilder<MenuItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MenuItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MenuItem.t;
}

class MenuItemRepository {
  const MenuItemRepository._();

  /// Returns a list of [MenuItem]s matching the given query parameters.
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
  Future<List<MenuItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MenuItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MenuItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MenuItem>(
      where: where?.call(MenuItem.t),
      orderBy: orderBy?.call(MenuItem.t),
      orderByList: orderByList?.call(MenuItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MenuItem] matching the given query parameters.
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
  Future<MenuItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MenuItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<MenuItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MenuItem>(
      where: where?.call(MenuItem.t),
      orderBy: orderBy?.call(MenuItem.t),
      orderByList: orderByList?.call(MenuItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MenuItem] by its [id] or null if no such row exists.
  Future<MenuItem?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MenuItem>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MenuItem]s in the list and returns the inserted rows.
  ///
  /// The returned [MenuItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MenuItem>> insert(
    _i1.Session session,
    List<MenuItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MenuItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MenuItem] and returns the inserted row.
  ///
  /// The returned [MenuItem] will have its `id` field set.
  Future<MenuItem> insertRow(
    _i1.Session session,
    MenuItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MenuItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MenuItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MenuItem>> update(
    _i1.Session session,
    List<MenuItem> rows, {
    _i1.ColumnSelections<MenuItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MenuItem>(
      rows,
      columns: columns?.call(MenuItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MenuItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MenuItem> updateRow(
    _i1.Session session,
    MenuItem row, {
    _i1.ColumnSelections<MenuItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MenuItem>(
      row,
      columns: columns?.call(MenuItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MenuItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MenuItem?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MenuItemUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MenuItem>(
      id,
      columnValues: columnValues(MenuItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MenuItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MenuItem>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MenuItemUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MenuItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MenuItemTable>? orderBy,
    _i1.OrderByListBuilder<MenuItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MenuItem>(
      columnValues: columnValues(MenuItem.t.updateTable),
      where: where(MenuItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MenuItem.t),
      orderByList: orderByList?.call(MenuItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MenuItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MenuItem>> delete(
    _i1.Session session,
    List<MenuItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MenuItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MenuItem].
  Future<MenuItem> deleteRow(
    _i1.Session session,
    MenuItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MenuItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MenuItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MenuItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MenuItem>(
      where: where(MenuItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MenuItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MenuItem>(
      where: where?.call(MenuItem.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
