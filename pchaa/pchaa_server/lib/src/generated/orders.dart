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
import 'order_status.dart' as _i2;
import 'order_type.dart' as _i3;

abstract class Order implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Order._({
    this.id,
    required this.userId,
    required this.status,
    required this.type,
    this.pickupTime,
    this.queueNumber,
    this.replyMessage,
    required this.totalOrderPrice,
    required this.orderDate,
    this.createdAt,
  });

  factory Order({
    int? id,
    required int userId,
    required _i2.OrderStatus status,
    required _i3.OrderType type,
    DateTime? pickupTime,
    String? queueNumber,
    String? replyMessage,
    required double totalOrderPrice,
    required DateTime orderDate,
    DateTime? createdAt,
  }) = _OrderImpl;

  factory Order.fromJson(Map<String, dynamic> jsonSerialization) {
    return Order(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      status: _i2.OrderStatus.fromJson((jsonSerialization['status'] as String)),
      type: _i3.OrderType.fromJson((jsonSerialization['type'] as String)),
      pickupTime: jsonSerialization['pickupTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['pickupTime']),
      queueNumber: jsonSerialization['queueNumber'] as String?,
      replyMessage: jsonSerialization['replyMessage'] as String?,
      totalOrderPrice: (jsonSerialization['totalOrderPrice'] as num).toDouble(),
      orderDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['orderDate'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = OrderTable();

  static const db = OrderRepository._();

  @override
  int? id;

  int userId;

  _i2.OrderStatus status;

  _i3.OrderType type;

  DateTime? pickupTime;

  String? queueNumber;

  String? replyMessage;

  double totalOrderPrice;

  DateTime orderDate;

  DateTime? createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Order copyWith({
    int? id,
    int? userId,
    _i2.OrderStatus? status,
    _i3.OrderType? type,
    DateTime? pickupTime,
    String? queueNumber,
    String? replyMessage,
    double? totalOrderPrice,
    DateTime? orderDate,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Order',
      if (id != null) 'id': id,
      'userId': userId,
      'status': status.toJson(),
      'type': type.toJson(),
      if (pickupTime != null) 'pickupTime': pickupTime?.toJson(),
      if (queueNumber != null) 'queueNumber': queueNumber,
      if (replyMessage != null) 'replyMessage': replyMessage,
      'totalOrderPrice': totalOrderPrice,
      'orderDate': orderDate.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Order',
      if (id != null) 'id': id,
      'userId': userId,
      'status': status.toJson(),
      'type': type.toJson(),
      if (pickupTime != null) 'pickupTime': pickupTime?.toJson(),
      if (queueNumber != null) 'queueNumber': queueNumber,
      if (replyMessage != null) 'replyMessage': replyMessage,
      'totalOrderPrice': totalOrderPrice,
      'orderDate': orderDate.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  static OrderInclude include() {
    return OrderInclude._();
  }

  static OrderIncludeList includeList({
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTable>? orderByList,
    OrderInclude? include,
  }) {
    return OrderIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Order.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Order.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderImpl extends Order {
  _OrderImpl({
    int? id,
    required int userId,
    required _i2.OrderStatus status,
    required _i3.OrderType type,
    DateTime? pickupTime,
    String? queueNumber,
    String? replyMessage,
    required double totalOrderPrice,
    required DateTime orderDate,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         status: status,
         type: type,
         pickupTime: pickupTime,
         queueNumber: queueNumber,
         replyMessage: replyMessage,
         totalOrderPrice: totalOrderPrice,
         orderDate: orderDate,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Order copyWith({
    Object? id = _Undefined,
    int? userId,
    _i2.OrderStatus? status,
    _i3.OrderType? type,
    Object? pickupTime = _Undefined,
    Object? queueNumber = _Undefined,
    Object? replyMessage = _Undefined,
    double? totalOrderPrice,
    DateTime? orderDate,
    Object? createdAt = _Undefined,
  }) {
    return Order(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      type: type ?? this.type,
      pickupTime: pickupTime is DateTime? ? pickupTime : this.pickupTime,
      queueNumber: queueNumber is String? ? queueNumber : this.queueNumber,
      replyMessage: replyMessage is String? ? replyMessage : this.replyMessage,
      totalOrderPrice: totalOrderPrice ?? this.totalOrderPrice,
      orderDate: orderDate ?? this.orderDate,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}

class OrderUpdateTable extends _i1.UpdateTable<OrderTable> {
  OrderUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<_i2.OrderStatus, _i2.OrderStatus> status(
    _i2.OrderStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<_i3.OrderType, _i3.OrderType> type(_i3.OrderType value) =>
      _i1.ColumnValue(
        table.type,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> pickupTime(DateTime? value) =>
      _i1.ColumnValue(
        table.pickupTime,
        value,
      );

  _i1.ColumnValue<String, String> queueNumber(String? value) => _i1.ColumnValue(
    table.queueNumber,
    value,
  );

  _i1.ColumnValue<String, String> replyMessage(String? value) =>
      _i1.ColumnValue(
        table.replyMessage,
        value,
      );

  _i1.ColumnValue<double, double> totalOrderPrice(double value) =>
      _i1.ColumnValue(
        table.totalOrderPrice,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> orderDate(DateTime value) =>
      _i1.ColumnValue(
        table.orderDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class OrderTable extends _i1.Table<int?> {
  OrderTable({super.tableRelation}) : super(tableName: 'orders') {
    updateTable = OrderUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    pickupTime = _i1.ColumnDateTime(
      'pickupTime',
      this,
    );
    queueNumber = _i1.ColumnString(
      'queueNumber',
      this,
    );
    replyMessage = _i1.ColumnString(
      'replyMessage',
      this,
    );
    totalOrderPrice = _i1.ColumnDouble(
      'totalOrderPrice',
      this,
    );
    orderDate = _i1.ColumnDateTime(
      'orderDate',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final OrderUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnEnum<_i2.OrderStatus> status;

  late final _i1.ColumnEnum<_i3.OrderType> type;

  late final _i1.ColumnDateTime pickupTime;

  late final _i1.ColumnString queueNumber;

  late final _i1.ColumnString replyMessage;

  late final _i1.ColumnDouble totalOrderPrice;

  late final _i1.ColumnDateTime orderDate;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    status,
    type,
    pickupTime,
    queueNumber,
    replyMessage,
    totalOrderPrice,
    orderDate,
    createdAt,
  ];
}

class OrderInclude extends _i1.IncludeObject {
  OrderInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Order.t;
}

class OrderIncludeList extends _i1.IncludeList {
  OrderIncludeList._({
    _i1.WhereExpressionBuilder<OrderTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Order.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Order.t;
}

class OrderRepository {
  const OrderRepository._();

  /// Returns a list of [Order]s matching the given query parameters.
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
  Future<List<Order>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Order>(
      where: where?.call(Order.t),
      orderBy: orderBy?.call(Order.t),
      orderByList: orderByList?.call(Order.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Order] matching the given query parameters.
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
  Future<Order?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Order>(
      where: where?.call(Order.t),
      orderBy: orderBy?.call(Order.t),
      orderByList: orderByList?.call(Order.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Order] by its [id] or null if no such row exists.
  Future<Order?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Order>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Order]s in the list and returns the inserted rows.
  ///
  /// The returned [Order]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Order>> insert(
    _i1.Session session,
    List<Order> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Order>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Order] and returns the inserted row.
  ///
  /// The returned [Order] will have its `id` field set.
  Future<Order> insertRow(
    _i1.Session session,
    Order row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Order>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Order]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Order>> update(
    _i1.Session session,
    List<Order> rows, {
    _i1.ColumnSelections<OrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Order>(
      rows,
      columns: columns?.call(Order.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Order]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Order> updateRow(
    _i1.Session session,
    Order row, {
    _i1.ColumnSelections<OrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Order>(
      row,
      columns: columns?.call(Order.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Order] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Order?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<OrderUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Order>(
      id,
      columnValues: columnValues(Order.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Order]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Order>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<OrderUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OrderTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderTable>? orderBy,
    _i1.OrderByListBuilder<OrderTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Order>(
      columnValues: columnValues(Order.t.updateTable),
      where: where(Order.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Order.t),
      orderByList: orderByList?.call(Order.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Order]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Order>> delete(
    _i1.Session session,
    List<Order> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Order>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Order].
  Future<Order> deleteRow(
    _i1.Session session,
    Order row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Order>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Order>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrderTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Order>(
      where: where(Order.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Order>(
      where: where?.call(Order.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
