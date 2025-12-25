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
import 'selected_option.dart' as _i2;
import 'package:pchaa_server/src/generated/protocol.dart' as _i3;

abstract class Cart implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Cart._({
    this.id,
    required this.userId,
    required this.menuItemId,
    required this.selectedOptions,
    this.additionalMessage,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.createdAt,
  });

  factory Cart({
    int? id,
    required int userId,
    required int menuItemId,
    required List<_i2.SelectedOption> selectedOptions,
    String? additionalMessage,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    DateTime? createdAt,
  }) = _CartImpl;

  factory Cart.fromJson(Map<String, dynamic> jsonSerialization) {
    return Cart(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      menuItemId: jsonSerialization['menuItemId'] as int,
      selectedOptions: _i3.Protocol().deserialize<List<_i2.SelectedOption>>(
        jsonSerialization['selectedOptions'],
      ),
      additionalMessage: jsonSerialization['additionalMessage'] as String?,
      quantity: jsonSerialization['quantity'] as int,
      unitPrice: (jsonSerialization['unitPrice'] as num).toDouble(),
      totalPrice: (jsonSerialization['totalPrice'] as num).toDouble(),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CartTable();

  static const db = CartRepository._();

  @override
  int? id;

  int userId;

  int menuItemId;

  List<_i2.SelectedOption> selectedOptions;

  String? additionalMessage;

  int quantity;

  double unitPrice;

  double totalPrice;

  DateTime? createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Cart]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Cart copyWith({
    int? id,
    int? userId,
    int? menuItemId,
    List<_i2.SelectedOption>? selectedOptions,
    String? additionalMessage,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Cart',
      if (id != null) 'id': id,
      'userId': userId,
      'menuItemId': menuItemId,
      'selectedOptions': selectedOptions.toJson(valueToJson: (v) => v.toJson()),
      if (additionalMessage != null) 'additionalMessage': additionalMessage,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Cart',
      if (id != null) 'id': id,
      'userId': userId,
      'menuItemId': menuItemId,
      'selectedOptions': selectedOptions.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (additionalMessage != null) 'additionalMessage': additionalMessage,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  static CartInclude include() {
    return CartInclude._();
  }

  static CartIncludeList includeList({
    _i1.WhereExpressionBuilder<CartTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CartTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CartTable>? orderByList,
    CartInclude? include,
  }) {
    return CartIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Cart.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Cart.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CartImpl extends Cart {
  _CartImpl({
    int? id,
    required int userId,
    required int menuItemId,
    required List<_i2.SelectedOption> selectedOptions,
    String? additionalMessage,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         menuItemId: menuItemId,
         selectedOptions: selectedOptions,
         additionalMessage: additionalMessage,
         quantity: quantity,
         unitPrice: unitPrice,
         totalPrice: totalPrice,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Cart]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Cart copyWith({
    Object? id = _Undefined,
    int? userId,
    int? menuItemId,
    List<_i2.SelectedOption>? selectedOptions,
    Object? additionalMessage = _Undefined,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    Object? createdAt = _Undefined,
  }) {
    return Cart(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      menuItemId: menuItemId ?? this.menuItemId,
      selectedOptions:
          selectedOptions ??
          this.selectedOptions.map((e0) => e0.copyWith()).toList(),
      additionalMessage: additionalMessage is String?
          ? additionalMessage
          : this.additionalMessage,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}

class CartUpdateTable extends _i1.UpdateTable<CartTable> {
  CartUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> menuItemId(int value) => _i1.ColumnValue(
    table.menuItemId,
    value,
  );

  _i1.ColumnValue<List<_i2.SelectedOption>, List<_i2.SelectedOption>>
  selectedOptions(List<_i2.SelectedOption> value) => _i1.ColumnValue(
    table.selectedOptions,
    value,
  );

  _i1.ColumnValue<String, String> additionalMessage(String? value) =>
      _i1.ColumnValue(
        table.additionalMessage,
        value,
      );

  _i1.ColumnValue<int, int> quantity(int value) => _i1.ColumnValue(
    table.quantity,
    value,
  );

  _i1.ColumnValue<double, double> unitPrice(double value) => _i1.ColumnValue(
    table.unitPrice,
    value,
  );

  _i1.ColumnValue<double, double> totalPrice(double value) => _i1.ColumnValue(
    table.totalPrice,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CartTable extends _i1.Table<int?> {
  CartTable({super.tableRelation}) : super(tableName: 'carts') {
    updateTable = CartUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    menuItemId = _i1.ColumnInt(
      'menuItemId',
      this,
    );
    selectedOptions = _i1.ColumnSerializable<List<_i2.SelectedOption>>(
      'selectedOptions',
      this,
    );
    additionalMessage = _i1.ColumnString(
      'additionalMessage',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    unitPrice = _i1.ColumnDouble(
      'unitPrice',
      this,
    );
    totalPrice = _i1.ColumnDouble(
      'totalPrice',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final CartUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt menuItemId;

  late final _i1.ColumnSerializable<List<_i2.SelectedOption>> selectedOptions;

  late final _i1.ColumnString additionalMessage;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnDouble unitPrice;

  late final _i1.ColumnDouble totalPrice;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    menuItemId,
    selectedOptions,
    additionalMessage,
    quantity,
    unitPrice,
    totalPrice,
    createdAt,
  ];
}

class CartInclude extends _i1.IncludeObject {
  CartInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Cart.t;
}

class CartIncludeList extends _i1.IncludeList {
  CartIncludeList._({
    _i1.WhereExpressionBuilder<CartTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Cart.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Cart.t;
}

class CartRepository {
  const CartRepository._();

  /// Returns a list of [Cart]s matching the given query parameters.
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
  Future<List<Cart>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CartTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CartTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CartTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Cart>(
      where: where?.call(Cart.t),
      orderBy: orderBy?.call(Cart.t),
      orderByList: orderByList?.call(Cart.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Cart] matching the given query parameters.
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
  Future<Cart?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CartTable>? where,
    int? offset,
    _i1.OrderByBuilder<CartTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CartTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Cart>(
      where: where?.call(Cart.t),
      orderBy: orderBy?.call(Cart.t),
      orderByList: orderByList?.call(Cart.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Cart] by its [id] or null if no such row exists.
  Future<Cart?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Cart>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Cart]s in the list and returns the inserted rows.
  ///
  /// The returned [Cart]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Cart>> insert(
    _i1.Session session,
    List<Cart> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Cart>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Cart] and returns the inserted row.
  ///
  /// The returned [Cart] will have its `id` field set.
  Future<Cart> insertRow(
    _i1.Session session,
    Cart row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Cart>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Cart]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Cart>> update(
    _i1.Session session,
    List<Cart> rows, {
    _i1.ColumnSelections<CartTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Cart>(
      rows,
      columns: columns?.call(Cart.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Cart]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Cart> updateRow(
    _i1.Session session,
    Cart row, {
    _i1.ColumnSelections<CartTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Cart>(
      row,
      columns: columns?.call(Cart.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Cart] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Cart?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CartUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Cart>(
      id,
      columnValues: columnValues(Cart.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Cart]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Cart>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CartUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CartTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CartTable>? orderBy,
    _i1.OrderByListBuilder<CartTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Cart>(
      columnValues: columnValues(Cart.t.updateTable),
      where: where(Cart.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Cart.t),
      orderByList: orderByList?.call(Cart.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Cart]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Cart>> delete(
    _i1.Session session,
    List<Cart> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Cart>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Cart].
  Future<Cart> deleteRow(
    _i1.Session session,
    Cart row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Cart>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Cart>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CartTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Cart>(
      where: where(Cart.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CartTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Cart>(
      where: where?.call(Cart.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
