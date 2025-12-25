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

abstract class OrderItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OrderItem._({
    this.id,
    required this.orderId,
    this.menuItemId,
    required this.itemName,
    required this.selectedOptions,
    this.additionalMessage,
    required this.quantity,
    required this.finalPrice,
  });

  factory OrderItem({
    int? id,
    required int orderId,
    int? menuItemId,
    required String itemName,
    required List<_i2.SelectedOption> selectedOptions,
    String? additionalMessage,
    required int quantity,
    required double finalPrice,
  }) = _OrderItemImpl;

  factory OrderItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderItem(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      menuItemId: jsonSerialization['menuItemId'] as int?,
      itemName: jsonSerialization['itemName'] as String,
      selectedOptions: _i3.Protocol().deserialize<List<_i2.SelectedOption>>(
        jsonSerialization['selectedOptions'],
      ),
      additionalMessage: jsonSerialization['additionalMessage'] as String?,
      quantity: jsonSerialization['quantity'] as int,
      finalPrice: (jsonSerialization['finalPrice'] as num).toDouble(),
    );
  }

  static final t = OrderItemTable();

  static const db = OrderItemRepository._();

  @override
  int? id;

  int orderId;

  int? menuItemId;

  String itemName;

  List<_i2.SelectedOption> selectedOptions;

  String? additionalMessage;

  int quantity;

  double finalPrice;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderItem copyWith({
    int? id,
    int? orderId,
    int? menuItemId,
    String? itemName,
    List<_i2.SelectedOption>? selectedOptions,
    String? additionalMessage,
    int? quantity,
    double? finalPrice,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderItem',
      if (id != null) 'id': id,
      'orderId': orderId,
      if (menuItemId != null) 'menuItemId': menuItemId,
      'itemName': itemName,
      'selectedOptions': selectedOptions.toJson(valueToJson: (v) => v.toJson()),
      if (additionalMessage != null) 'additionalMessage': additionalMessage,
      'quantity': quantity,
      'finalPrice': finalPrice,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderItem',
      if (id != null) 'id': id,
      'orderId': orderId,
      if (menuItemId != null) 'menuItemId': menuItemId,
      'itemName': itemName,
      'selectedOptions': selectedOptions.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (additionalMessage != null) 'additionalMessage': additionalMessage,
      'quantity': quantity,
      'finalPrice': finalPrice,
    };
  }

  static OrderItemInclude include() {
    return OrderItemInclude._();
  }

  static OrderItemIncludeList includeList({
    _i1.WhereExpressionBuilder<OrderItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderItemTable>? orderByList,
    OrderItemInclude? include,
  }) {
    return OrderItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrderItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderItemImpl extends OrderItem {
  _OrderItemImpl({
    int? id,
    required int orderId,
    int? menuItemId,
    required String itemName,
    required List<_i2.SelectedOption> selectedOptions,
    String? additionalMessage,
    required int quantity,
    required double finalPrice,
  }) : super._(
         id: id,
         orderId: orderId,
         menuItemId: menuItemId,
         itemName: itemName,
         selectedOptions: selectedOptions,
         additionalMessage: additionalMessage,
         quantity: quantity,
         finalPrice: finalPrice,
       );

  /// Returns a shallow copy of this [OrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderItem copyWith({
    Object? id = _Undefined,
    int? orderId,
    Object? menuItemId = _Undefined,
    String? itemName,
    List<_i2.SelectedOption>? selectedOptions,
    Object? additionalMessage = _Undefined,
    int? quantity,
    double? finalPrice,
  }) {
    return OrderItem(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      menuItemId: menuItemId is int? ? menuItemId : this.menuItemId,
      itemName: itemName ?? this.itemName,
      selectedOptions:
          selectedOptions ??
          this.selectedOptions.map((e0) => e0.copyWith()).toList(),
      additionalMessage: additionalMessage is String?
          ? additionalMessage
          : this.additionalMessage,
      quantity: quantity ?? this.quantity,
      finalPrice: finalPrice ?? this.finalPrice,
    );
  }
}

class OrderItemUpdateTable extends _i1.UpdateTable<OrderItemTable> {
  OrderItemUpdateTable(super.table);

  _i1.ColumnValue<int, int> orderId(int value) => _i1.ColumnValue(
    table.orderId,
    value,
  );

  _i1.ColumnValue<int, int> menuItemId(int? value) => _i1.ColumnValue(
    table.menuItemId,
    value,
  );

  _i1.ColumnValue<String, String> itemName(String value) => _i1.ColumnValue(
    table.itemName,
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

  _i1.ColumnValue<double, double> finalPrice(double value) => _i1.ColumnValue(
    table.finalPrice,
    value,
  );
}

class OrderItemTable extends _i1.Table<int?> {
  OrderItemTable({super.tableRelation}) : super(tableName: 'order_items') {
    updateTable = OrderItemUpdateTable(this);
    orderId = _i1.ColumnInt(
      'orderId',
      this,
    );
    menuItemId = _i1.ColumnInt(
      'menuItemId',
      this,
    );
    itemName = _i1.ColumnString(
      'itemName',
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
    finalPrice = _i1.ColumnDouble(
      'finalPrice',
      this,
    );
  }

  late final OrderItemUpdateTable updateTable;

  late final _i1.ColumnInt orderId;

  late final _i1.ColumnInt menuItemId;

  late final _i1.ColumnString itemName;

  late final _i1.ColumnSerializable<List<_i2.SelectedOption>> selectedOptions;

  late final _i1.ColumnString additionalMessage;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnDouble finalPrice;

  @override
  List<_i1.Column> get columns => [
    id,
    orderId,
    menuItemId,
    itemName,
    selectedOptions,
    additionalMessage,
    quantity,
    finalPrice,
  ];
}

class OrderItemInclude extends _i1.IncludeObject {
  OrderItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OrderItem.t;
}

class OrderItemIncludeList extends _i1.IncludeList {
  OrderItemIncludeList._({
    _i1.WhereExpressionBuilder<OrderItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrderItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OrderItem.t;
}

class OrderItemRepository {
  const OrderItemRepository._();

  /// Returns a list of [OrderItem]s matching the given query parameters.
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
  Future<List<OrderItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<OrderItem>(
      where: where?.call(OrderItem.t),
      orderBy: orderBy?.call(OrderItem.t),
      orderByList: orderByList?.call(OrderItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [OrderItem] matching the given query parameters.
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
  Future<OrderItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrderItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<OrderItem>(
      where: where?.call(OrderItem.t),
      orderBy: orderBy?.call(OrderItem.t),
      orderByList: orderByList?.call(OrderItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [OrderItem] by its [id] or null if no such row exists.
  Future<OrderItem?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<OrderItem>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [OrderItem]s in the list and returns the inserted rows.
  ///
  /// The returned [OrderItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<OrderItem>> insert(
    _i1.Session session,
    List<OrderItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<OrderItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [OrderItem] and returns the inserted row.
  ///
  /// The returned [OrderItem] will have its `id` field set.
  Future<OrderItem> insertRow(
    _i1.Session session,
    OrderItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrderItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrderItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrderItem>> update(
    _i1.Session session,
    List<OrderItem> rows, {
    _i1.ColumnSelections<OrderItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrderItem>(
      rows,
      columns: columns?.call(OrderItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrderItem> updateRow(
    _i1.Session session,
    OrderItem row, {
    _i1.ColumnSelections<OrderItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrderItem>(
      row,
      columns: columns?.call(OrderItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OrderItem?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<OrderItemUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OrderItem>(
      id,
      columnValues: columnValues(OrderItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OrderItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OrderItem>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<OrderItemUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OrderItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderItemTable>? orderBy,
    _i1.OrderByListBuilder<OrderItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OrderItem>(
      columnValues: columnValues(OrderItem.t.updateTable),
      where: where(OrderItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderItem.t),
      orderByList: orderByList?.call(OrderItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OrderItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrderItem>> delete(
    _i1.Session session,
    List<OrderItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrderItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrderItem].
  Future<OrderItem> deleteRow(
    _i1.Session session,
    OrderItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrderItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrderItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrderItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrderItem>(
      where: where(OrderItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrderItem>(
      where: where?.call(OrderItem.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
