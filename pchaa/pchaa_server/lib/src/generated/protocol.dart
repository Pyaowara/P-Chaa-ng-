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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'add_on_option.dart' as _i5;
import 'carts.dart' as _i6;
import 'customization_group.dart' as _i7;
import 'daily_queue_counters.dart' as _i8;
import 'greetings/greeting.dart' as _i9;
import 'menu_items.dart' as _i10;
import 'order_items.dart' as _i11;
import 'order_status.dart' as _i12;
import 'order_type.dart' as _i13;
import 'orders.dart' as _i14;
import 'selected_option.dart' as _i15;
import 'store_settings.dart' as _i16;
import 'user_role.dart' as _i17;
import 'users.dart' as _i18;
export 'add_on_option.dart';
export 'carts.dart';
export 'customization_group.dart';
export 'daily_queue_counters.dart';
export 'greetings/greeting.dart';
export 'menu_items.dart';
export 'order_items.dart';
export 'order_status.dart';
export 'order_type.dart';
export 'orders.dart';
export 'selected_option.dart';
export 'store_settings.dart';
export 'user_role.dart';
export 'users.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'carts',
      dartName: 'Cart',
      schema: 'public',
      module: 'pchaa',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'carts_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'menuItemId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'selectedOptions',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:SelectedOption>',
        ),
        _i2.ColumnDefinition(
          name: 'additionalMessage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'unitPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'totalPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'carts_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'daily_queue_counters',
      dartName: 'DailyQueueCounter',
      schema: 'public',
      module: 'pchaa',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'daily_queue_counters_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'queueDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'iCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'daily_queue_counters_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'menu_items',
      dartName: 'MenuItem',
      schema: 'public',
      module: 'pchaa',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'menu_items_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'basePrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'timeToPrepare',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'customization',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:CustomizationGroup>',
        ),
        _i2.ColumnDefinition(
          name: 's3Key',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isAvailable',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'menu_items_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'order_items',
      dartName: 'OrderItem',
      schema: 'public',
      module: 'pchaa',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'order_items_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'menuItemId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'itemName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'selectedOptions',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:SelectedOption>',
        ),
        _i2.ColumnDefinition(
          name: 'additionalMessage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'finalPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'order_items_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'orders',
      dartName: 'Order',
      schema: 'public',
      module: 'pchaa',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'orders_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OrderStatus',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OrderType',
        ),
        _i2.ColumnDefinition(
          name: 'pickupTime',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'queueNumber',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'replyMessage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'totalOrderPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'orderDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'orders_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'store_settings',
      dartName: 'StoreSettings',
      schema: 'public',
      module: 'pchaa',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'store_settings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'isOpen',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'openTime',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'closeTime',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'autoOpenClose',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 's3Key',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'store_settings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'users',
      dartName: 'User',
      schema: 'public',
      module: 'pchaa',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'users_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'username',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'passwordHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'phoneNumber',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:UserRole',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'users_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.AddOnOption) {
      return _i5.AddOnOption.fromJson(data) as T;
    }
    if (t == _i6.Cart) {
      return _i6.Cart.fromJson(data) as T;
    }
    if (t == _i7.CustomizationGroup) {
      return _i7.CustomizationGroup.fromJson(data) as T;
    }
    if (t == _i8.DailyQueueCounter) {
      return _i8.DailyQueueCounter.fromJson(data) as T;
    }
    if (t == _i9.Greeting) {
      return _i9.Greeting.fromJson(data) as T;
    }
    if (t == _i10.MenuItem) {
      return _i10.MenuItem.fromJson(data) as T;
    }
    if (t == _i11.OrderItem) {
      return _i11.OrderItem.fromJson(data) as T;
    }
    if (t == _i12.OrderStatus) {
      return _i12.OrderStatus.fromJson(data) as T;
    }
    if (t == _i13.OrderType) {
      return _i13.OrderType.fromJson(data) as T;
    }
    if (t == _i14.Order) {
      return _i14.Order.fromJson(data) as T;
    }
    if (t == _i15.SelectedOption) {
      return _i15.SelectedOption.fromJson(data) as T;
    }
    if (t == _i16.StoreSettings) {
      return _i16.StoreSettings.fromJson(data) as T;
    }
    if (t == _i17.UserRole) {
      return _i17.UserRole.fromJson(data) as T;
    }
    if (t == _i18.User) {
      return _i18.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AddOnOption?>()) {
      return (data != null ? _i5.AddOnOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Cart?>()) {
      return (data != null ? _i6.Cart.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CustomizationGroup?>()) {
      return (data != null ? _i7.CustomizationGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.DailyQueueCounter?>()) {
      return (data != null ? _i8.DailyQueueCounter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Greeting?>()) {
      return (data != null ? _i9.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.MenuItem?>()) {
      return (data != null ? _i10.MenuItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.OrderItem?>()) {
      return (data != null ? _i11.OrderItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.OrderStatus?>()) {
      return (data != null ? _i12.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.OrderType?>()) {
      return (data != null ? _i13.OrderType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Order?>()) {
      return (data != null ? _i14.Order.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.SelectedOption?>()) {
      return (data != null ? _i15.SelectedOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.StoreSettings?>()) {
      return (data != null ? _i16.StoreSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.UserRole?>()) {
      return (data != null ? _i17.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.User?>()) {
      return (data != null ? _i18.User.fromJson(data) : null) as T;
    }
    if (t == List<_i15.SelectedOption>) {
      return (data as List)
              .map((e) => deserialize<_i15.SelectedOption>(e))
              .toList()
          as T;
    }
    if (t == List<_i5.AddOnOption>) {
      return (data as List).map((e) => deserialize<_i5.AddOnOption>(e)).toList()
          as T;
    }
    if (t == List<_i7.CustomizationGroup>) {
      return (data as List)
              .map((e) => deserialize<_i7.CustomizationGroup>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AddOnOption => 'AddOnOption',
      _i6.Cart => 'Cart',
      _i7.CustomizationGroup => 'CustomizationGroup',
      _i8.DailyQueueCounter => 'DailyQueueCounter',
      _i9.Greeting => 'Greeting',
      _i10.MenuItem => 'MenuItem',
      _i11.OrderItem => 'OrderItem',
      _i12.OrderStatus => 'OrderStatus',
      _i13.OrderType => 'OrderType',
      _i14.Order => 'Order',
      _i15.SelectedOption => 'SelectedOption',
      _i16.StoreSettings => 'StoreSettings',
      _i17.UserRole => 'UserRole',
      _i18.User => 'User',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('pchaa.', '');
    }

    switch (data) {
      case _i5.AddOnOption():
        return 'AddOnOption';
      case _i6.Cart():
        return 'Cart';
      case _i7.CustomizationGroup():
        return 'CustomizationGroup';
      case _i8.DailyQueueCounter():
        return 'DailyQueueCounter';
      case _i9.Greeting():
        return 'Greeting';
      case _i10.MenuItem():
        return 'MenuItem';
      case _i11.OrderItem():
        return 'OrderItem';
      case _i12.OrderStatus():
        return 'OrderStatus';
      case _i13.OrderType():
        return 'OrderType';
      case _i14.Order():
        return 'Order';
      case _i15.SelectedOption():
        return 'SelectedOption';
      case _i16.StoreSettings():
        return 'StoreSettings';
      case _i17.UserRole():
        return 'UserRole';
      case _i18.User():
        return 'User';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AddOnOption') {
      return deserialize<_i5.AddOnOption>(data['data']);
    }
    if (dataClassName == 'Cart') {
      return deserialize<_i6.Cart>(data['data']);
    }
    if (dataClassName == 'CustomizationGroup') {
      return deserialize<_i7.CustomizationGroup>(data['data']);
    }
    if (dataClassName == 'DailyQueueCounter') {
      return deserialize<_i8.DailyQueueCounter>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i9.Greeting>(data['data']);
    }
    if (dataClassName == 'MenuItem') {
      return deserialize<_i10.MenuItem>(data['data']);
    }
    if (dataClassName == 'OrderItem') {
      return deserialize<_i11.OrderItem>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i12.OrderStatus>(data['data']);
    }
    if (dataClassName == 'OrderType') {
      return deserialize<_i13.OrderType>(data['data']);
    }
    if (dataClassName == 'Order') {
      return deserialize<_i14.Order>(data['data']);
    }
    if (dataClassName == 'SelectedOption') {
      return deserialize<_i15.SelectedOption>(data['data']);
    }
    if (dataClassName == 'StoreSettings') {
      return deserialize<_i16.StoreSettings>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i17.UserRole>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i18.User>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i6.Cart:
        return _i6.Cart.t;
      case _i8.DailyQueueCounter:
        return _i8.DailyQueueCounter.t;
      case _i10.MenuItem:
        return _i10.MenuItem.t;
      case _i11.OrderItem:
        return _i11.OrderItem.t;
      case _i14.Order:
        return _i14.Order.t;
      case _i16.StoreSettings:
        return _i16.StoreSettings.t;
      case _i18.User:
        return _i18.User.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'pchaa';
}
