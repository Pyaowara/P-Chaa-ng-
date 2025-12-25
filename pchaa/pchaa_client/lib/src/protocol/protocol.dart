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
import 'add_on_option.dart' as _i2;
import 'carts.dart' as _i3;
import 'customization_group.dart' as _i4;
import 'daily_queue_counters.dart' as _i5;
import 'greetings/greeting.dart' as _i6;
import 'menu_items.dart' as _i7;
import 'order_items.dart' as _i8;
import 'order_status.dart' as _i9;
import 'order_type.dart' as _i10;
import 'orders.dart' as _i11;
import 'selected_option.dart' as _i12;
import 'store_settings.dart' as _i13;
import 'user_role.dart' as _i14;
import 'users.dart' as _i15;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i16;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i17;
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.AddOnOption) {
      return _i2.AddOnOption.fromJson(data) as T;
    }
    if (t == _i3.Cart) {
      return _i3.Cart.fromJson(data) as T;
    }
    if (t == _i4.CustomizationGroup) {
      return _i4.CustomizationGroup.fromJson(data) as T;
    }
    if (t == _i5.DailyQueueCounter) {
      return _i5.DailyQueueCounter.fromJson(data) as T;
    }
    if (t == _i6.Greeting) {
      return _i6.Greeting.fromJson(data) as T;
    }
    if (t == _i7.MenuItem) {
      return _i7.MenuItem.fromJson(data) as T;
    }
    if (t == _i8.OrderItem) {
      return _i8.OrderItem.fromJson(data) as T;
    }
    if (t == _i9.OrderStatus) {
      return _i9.OrderStatus.fromJson(data) as T;
    }
    if (t == _i10.OrderType) {
      return _i10.OrderType.fromJson(data) as T;
    }
    if (t == _i11.Order) {
      return _i11.Order.fromJson(data) as T;
    }
    if (t == _i12.SelectedOption) {
      return _i12.SelectedOption.fromJson(data) as T;
    }
    if (t == _i13.StoreSettings) {
      return _i13.StoreSettings.fromJson(data) as T;
    }
    if (t == _i14.UserRole) {
      return _i14.UserRole.fromJson(data) as T;
    }
    if (t == _i15.User) {
      return _i15.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AddOnOption?>()) {
      return (data != null ? _i2.AddOnOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Cart?>()) {
      return (data != null ? _i3.Cart.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.CustomizationGroup?>()) {
      return (data != null ? _i4.CustomizationGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.DailyQueueCounter?>()) {
      return (data != null ? _i5.DailyQueueCounter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Greeting?>()) {
      return (data != null ? _i6.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.MenuItem?>()) {
      return (data != null ? _i7.MenuItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.OrderItem?>()) {
      return (data != null ? _i8.OrderItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.OrderStatus?>()) {
      return (data != null ? _i9.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.OrderType?>()) {
      return (data != null ? _i10.OrderType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Order?>()) {
      return (data != null ? _i11.Order.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.SelectedOption?>()) {
      return (data != null ? _i12.SelectedOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.StoreSettings?>()) {
      return (data != null ? _i13.StoreSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.UserRole?>()) {
      return (data != null ? _i14.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.User?>()) {
      return (data != null ? _i15.User.fromJson(data) : null) as T;
    }
    if (t == List<_i12.SelectedOption>) {
      return (data as List)
              .map((e) => deserialize<_i12.SelectedOption>(e))
              .toList()
          as T;
    }
    if (t == List<_i2.AddOnOption>) {
      return (data as List).map((e) => deserialize<_i2.AddOnOption>(e)).toList()
          as T;
    }
    if (t == List<_i4.CustomizationGroup>) {
      return (data as List)
              .map((e) => deserialize<_i4.CustomizationGroup>(e))
              .toList()
          as T;
    }
    try {
      return _i16.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i17.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AddOnOption => 'AddOnOption',
      _i3.Cart => 'Cart',
      _i4.CustomizationGroup => 'CustomizationGroup',
      _i5.DailyQueueCounter => 'DailyQueueCounter',
      _i6.Greeting => 'Greeting',
      _i7.MenuItem => 'MenuItem',
      _i8.OrderItem => 'OrderItem',
      _i9.OrderStatus => 'OrderStatus',
      _i10.OrderType => 'OrderType',
      _i11.Order => 'Order',
      _i12.SelectedOption => 'SelectedOption',
      _i13.StoreSettings => 'StoreSettings',
      _i14.UserRole => 'UserRole',
      _i15.User => 'User',
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
      case _i2.AddOnOption():
        return 'AddOnOption';
      case _i3.Cart():
        return 'Cart';
      case _i4.CustomizationGroup():
        return 'CustomizationGroup';
      case _i5.DailyQueueCounter():
        return 'DailyQueueCounter';
      case _i6.Greeting():
        return 'Greeting';
      case _i7.MenuItem():
        return 'MenuItem';
      case _i8.OrderItem():
        return 'OrderItem';
      case _i9.OrderStatus():
        return 'OrderStatus';
      case _i10.OrderType():
        return 'OrderType';
      case _i11.Order():
        return 'Order';
      case _i12.SelectedOption():
        return 'SelectedOption';
      case _i13.StoreSettings():
        return 'StoreSettings';
      case _i14.UserRole():
        return 'UserRole';
      case _i15.User():
        return 'User';
    }
    className = _i16.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i17.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.AddOnOption>(data['data']);
    }
    if (dataClassName == 'Cart') {
      return deserialize<_i3.Cart>(data['data']);
    }
    if (dataClassName == 'CustomizationGroup') {
      return deserialize<_i4.CustomizationGroup>(data['data']);
    }
    if (dataClassName == 'DailyQueueCounter') {
      return deserialize<_i5.DailyQueueCounter>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i6.Greeting>(data['data']);
    }
    if (dataClassName == 'MenuItem') {
      return deserialize<_i7.MenuItem>(data['data']);
    }
    if (dataClassName == 'OrderItem') {
      return deserialize<_i8.OrderItem>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i9.OrderStatus>(data['data']);
    }
    if (dataClassName == 'OrderType') {
      return deserialize<_i10.OrderType>(data['data']);
    }
    if (dataClassName == 'Order') {
      return deserialize<_i11.Order>(data['data']);
    }
    if (dataClassName == 'SelectedOption') {
      return deserialize<_i12.SelectedOption>(data['data']);
    }
    if (dataClassName == 'StoreSettings') {
      return deserialize<_i13.StoreSettings>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i14.UserRole>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i15.User>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i16.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i17.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
