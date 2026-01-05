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
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i4;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i5;
import 'add_on_option.dart' as _i6;
import 'available_add_on_option.dart' as _i7;
import 'available_customization_group.dart' as _i8;
import 'available_menu_item.dart' as _i9;
import 'carts.dart' as _i10;
import 'customization_group.dart' as _i11;
import 'daily_queue_counters.dart' as _i12;
import 'greetings/greeting.dart' as _i13;
import 'ingredient.dart' as _i14;
import 'menu_item_with_url.dart' as _i15;
import 'menu_items.dart' as _i16;
import 'order_items.dart' as _i17;
import 'order_status.dart' as _i18;
import 'order_type.dart' as _i19;
import 'orders.dart' as _i20;
import 'selected_option.dart' as _i21;
import 'store_settings.dart' as _i22;
import 'user_role.dart' as _i23;
import 'users.dart' as _i24;
import 'package:pchaa_server/src/generated/ingredient.dart' as _i25;
import 'package:pchaa_server/src/generated/customization_group.dart' as _i26;
import 'package:pchaa_server/src/generated/menu_item_with_url.dart' as _i27;
import 'package:pchaa_server/src/generated/available_menu_item.dart' as _i28;
import 'package:pchaa_server/src/generated/users.dart' as _i29;
export 'add_on_option.dart';
export 'available_add_on_option.dart';
export 'available_customization_group.dart';
export 'available_menu_item.dart';
export 'carts.dart';
export 'customization_group.dart';
export 'daily_queue_counters.dart';
export 'greetings/greeting.dart';
export 'ingredient.dart';
export 'menu_item_with_url.dart';
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
      name: 'ingredients',
      dartName: 'Ingredient',
      schema: 'public',
      module: 'pchaa',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'ingredients_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isAvailable',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isDeleted',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ingredients_pkey',
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
        _i2.ColumnDefinition(
          name: 'ingredientIds',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
        _i2.ColumnDefinition(
          name: 'isDeleted',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
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
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fullName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'picture',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
    ..._i5.Protocol.targetTableDefinitions,
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

    if (t == _i6.AddOnOption) {
      return _i6.AddOnOption.fromJson(data) as T;
    }
    if (t == _i7.AvailableAddOnOption) {
      return _i7.AvailableAddOnOption.fromJson(data) as T;
    }
    if (t == _i8.AvailableCustomizationGroup) {
      return _i8.AvailableCustomizationGroup.fromJson(data) as T;
    }
    if (t == _i9.AvailableMenuItem) {
      return _i9.AvailableMenuItem.fromJson(data) as T;
    }
    if (t == _i10.Cart) {
      return _i10.Cart.fromJson(data) as T;
    }
    if (t == _i11.CustomizationGroup) {
      return _i11.CustomizationGroup.fromJson(data) as T;
    }
    if (t == _i12.DailyQueueCounter) {
      return _i12.DailyQueueCounter.fromJson(data) as T;
    }
    if (t == _i13.Greeting) {
      return _i13.Greeting.fromJson(data) as T;
    }
    if (t == _i14.Ingredient) {
      return _i14.Ingredient.fromJson(data) as T;
    }
    if (t == _i15.MenuItemWithUrl) {
      return _i15.MenuItemWithUrl.fromJson(data) as T;
    }
    if (t == _i16.MenuItem) {
      return _i16.MenuItem.fromJson(data) as T;
    }
    if (t == _i17.OrderItem) {
      return _i17.OrderItem.fromJson(data) as T;
    }
    if (t == _i18.OrderStatus) {
      return _i18.OrderStatus.fromJson(data) as T;
    }
    if (t == _i19.OrderType) {
      return _i19.OrderType.fromJson(data) as T;
    }
    if (t == _i20.Order) {
      return _i20.Order.fromJson(data) as T;
    }
    if (t == _i21.SelectedOption) {
      return _i21.SelectedOption.fromJson(data) as T;
    }
    if (t == _i22.StoreSettings) {
      return _i22.StoreSettings.fromJson(data) as T;
    }
    if (t == _i23.UserRole) {
      return _i23.UserRole.fromJson(data) as T;
    }
    if (t == _i24.User) {
      return _i24.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i6.AddOnOption?>()) {
      return (data != null ? _i6.AddOnOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AvailableAddOnOption?>()) {
      return (data != null ? _i7.AvailableAddOnOption.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.AvailableCustomizationGroup?>()) {
      return (data != null
              ? _i8.AvailableCustomizationGroup.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i9.AvailableMenuItem?>()) {
      return (data != null ? _i9.AvailableMenuItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Cart?>()) {
      return (data != null ? _i10.Cart.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CustomizationGroup?>()) {
      return (data != null ? _i11.CustomizationGroup.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.DailyQueueCounter?>()) {
      return (data != null ? _i12.DailyQueueCounter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Greeting?>()) {
      return (data != null ? _i13.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Ingredient?>()) {
      return (data != null ? _i14.Ingredient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.MenuItemWithUrl?>()) {
      return (data != null ? _i15.MenuItemWithUrl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.MenuItem?>()) {
      return (data != null ? _i16.MenuItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.OrderItem?>()) {
      return (data != null ? _i17.OrderItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.OrderStatus?>()) {
      return (data != null ? _i18.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.OrderType?>()) {
      return (data != null ? _i19.OrderType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Order?>()) {
      return (data != null ? _i20.Order.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.SelectedOption?>()) {
      return (data != null ? _i21.SelectedOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.StoreSettings?>()) {
      return (data != null ? _i22.StoreSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.UserRole?>()) {
      return (data != null ? _i23.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.User?>()) {
      return (data != null ? _i24.User.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i7.AvailableAddOnOption>) {
      return (data as List)
              .map((e) => deserialize<_i7.AvailableAddOnOption>(e))
              .toList()
          as T;
    }
    if (t == List<_i8.AvailableCustomizationGroup>) {
      return (data as List)
              .map((e) => deserialize<_i8.AvailableCustomizationGroup>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.SelectedOption>) {
      return (data as List)
              .map((e) => deserialize<_i21.SelectedOption>(e))
              .toList()
          as T;
    }
    if (t == List<_i6.AddOnOption>) {
      return (data as List).map((e) => deserialize<_i6.AddOnOption>(e)).toList()
          as T;
    }
    if (t == List<_i11.CustomizationGroup>) {
      return (data as List)
              .map((e) => deserialize<_i11.CustomizationGroup>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.Ingredient>) {
      return (data as List).map((e) => deserialize<_i25.Ingredient>(e)).toList()
          as T;
    }
    if (t == List<_i26.CustomizationGroup>) {
      return (data as List)
              .map((e) => deserialize<_i26.CustomizationGroup>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i27.MenuItemWithUrl>) {
      return (data as List)
              .map((e) => deserialize<_i27.MenuItemWithUrl>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.AvailableMenuItem>) {
      return (data as List)
              .map((e) => deserialize<_i28.AvailableMenuItem>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i26.CustomizationGroup>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i26.CustomizationGroup>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<_i29.User>) {
      return (data as List).map((e) => deserialize<_i29.User>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i29.User>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i29.User>(e)).toList()
              : null)
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i5.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i6.AddOnOption => 'AddOnOption',
      _i7.AvailableAddOnOption => 'AvailableAddOnOption',
      _i8.AvailableCustomizationGroup => 'AvailableCustomizationGroup',
      _i9.AvailableMenuItem => 'AvailableMenuItem',
      _i10.Cart => 'Cart',
      _i11.CustomizationGroup => 'CustomizationGroup',
      _i12.DailyQueueCounter => 'DailyQueueCounter',
      _i13.Greeting => 'Greeting',
      _i14.Ingredient => 'Ingredient',
      _i15.MenuItemWithUrl => 'MenuItemWithUrl',
      _i16.MenuItem => 'MenuItem',
      _i17.OrderItem => 'OrderItem',
      _i18.OrderStatus => 'OrderStatus',
      _i19.OrderType => 'OrderType',
      _i20.Order => 'Order',
      _i21.SelectedOption => 'SelectedOption',
      _i22.StoreSettings => 'StoreSettings',
      _i23.UserRole => 'UserRole',
      _i24.User => 'User',
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
      case _i6.AddOnOption():
        return 'AddOnOption';
      case _i7.AvailableAddOnOption():
        return 'AvailableAddOnOption';
      case _i8.AvailableCustomizationGroup():
        return 'AvailableCustomizationGroup';
      case _i9.AvailableMenuItem():
        return 'AvailableMenuItem';
      case _i10.Cart():
        return 'Cart';
      case _i11.CustomizationGroup():
        return 'CustomizationGroup';
      case _i12.DailyQueueCounter():
        return 'DailyQueueCounter';
      case _i13.Greeting():
        return 'Greeting';
      case _i14.Ingredient():
        return 'Ingredient';
      case _i15.MenuItemWithUrl():
        return 'MenuItemWithUrl';
      case _i16.MenuItem():
        return 'MenuItem';
      case _i17.OrderItem():
        return 'OrderItem';
      case _i18.OrderStatus():
        return 'OrderStatus';
      case _i19.OrderType():
        return 'OrderType';
      case _i20.Order():
        return 'Order';
      case _i21.SelectedOption():
        return 'SelectedOption';
      case _i22.StoreSettings():
        return 'StoreSettings';
      case _i23.UserRole():
        return 'UserRole';
      case _i24.User():
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
      return 'serverpod_auth.$className';
    }
    className = _i5.Protocol().getClassNameForObject(data);
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
      return deserialize<_i6.AddOnOption>(data['data']);
    }
    if (dataClassName == 'AvailableAddOnOption') {
      return deserialize<_i7.AvailableAddOnOption>(data['data']);
    }
    if (dataClassName == 'AvailableCustomizationGroup') {
      return deserialize<_i8.AvailableCustomizationGroup>(data['data']);
    }
    if (dataClassName == 'AvailableMenuItem') {
      return deserialize<_i9.AvailableMenuItem>(data['data']);
    }
    if (dataClassName == 'Cart') {
      return deserialize<_i10.Cart>(data['data']);
    }
    if (dataClassName == 'CustomizationGroup') {
      return deserialize<_i11.CustomizationGroup>(data['data']);
    }
    if (dataClassName == 'DailyQueueCounter') {
      return deserialize<_i12.DailyQueueCounter>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i13.Greeting>(data['data']);
    }
    if (dataClassName == 'Ingredient') {
      return deserialize<_i14.Ingredient>(data['data']);
    }
    if (dataClassName == 'MenuItemWithUrl') {
      return deserialize<_i15.MenuItemWithUrl>(data['data']);
    }
    if (dataClassName == 'MenuItem') {
      return deserialize<_i16.MenuItem>(data['data']);
    }
    if (dataClassName == 'OrderItem') {
      return deserialize<_i17.OrderItem>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i18.OrderStatus>(data['data']);
    }
    if (dataClassName == 'OrderType') {
      return deserialize<_i19.OrderType>(data['data']);
    }
    if (dataClassName == 'Order') {
      return deserialize<_i20.Order>(data['data']);
    }
    if (dataClassName == 'SelectedOption') {
      return deserialize<_i21.SelectedOption>(data['data']);
    }
    if (dataClassName == 'StoreSettings') {
      return deserialize<_i22.StoreSettings>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i23.UserRole>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i24.User>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i4.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i5.Protocol().deserializeByClassName(data);
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
      var table = _i5.Protocol().getTableForType(t);
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
      case _i10.Cart:
        return _i10.Cart.t;
      case _i12.DailyQueueCounter:
        return _i12.DailyQueueCounter.t;
      case _i14.Ingredient:
        return _i14.Ingredient.t;
      case _i16.MenuItem:
        return _i16.MenuItem.t;
      case _i17.OrderItem:
        return _i17.OrderItem.t;
      case _i20.Order:
        return _i20.Order.t;
      case _i22.StoreSettings:
        return _i22.StoreSettings.t;
      case _i24.User:
        return _i24.User.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'pchaa';
}
