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
import 'ingredient.dart' as _i7;
import 'menu_items.dart' as _i8;
import 'order_items.dart' as _i9;
import 'order_status.dart' as _i10;
import 'order_type.dart' as _i11;
import 'orders.dart' as _i12;
import 'selected_option.dart' as _i13;
import 'store_settings.dart' as _i14;
import 'user_role.dart' as _i15;
import 'users.dart' as _i16;
import 'package:pchaa_client/src/protocol/ingredient.dart' as _i17;
import 'package:pchaa_client/src/protocol/customization_group.dart' as _i18;
import 'package:pchaa_client/src/protocol/menu_items.dart' as _i19;
import 'package:pchaa_client/src/protocol/users.dart' as _i20;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i21;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i22;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i23;
export 'add_on_option.dart';
export 'carts.dart';
export 'customization_group.dart';
export 'daily_queue_counters.dart';
export 'greetings/greeting.dart';
export 'ingredient.dart';
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
    if (t == _i7.Ingredient) {
      return _i7.Ingredient.fromJson(data) as T;
    }
    if (t == _i8.MenuItem) {
      return _i8.MenuItem.fromJson(data) as T;
    }
    if (t == _i9.OrderItem) {
      return _i9.OrderItem.fromJson(data) as T;
    }
    if (t == _i10.OrderStatus) {
      return _i10.OrderStatus.fromJson(data) as T;
    }
    if (t == _i11.OrderType) {
      return _i11.OrderType.fromJson(data) as T;
    }
    if (t == _i12.Order) {
      return _i12.Order.fromJson(data) as T;
    }
    if (t == _i13.SelectedOption) {
      return _i13.SelectedOption.fromJson(data) as T;
    }
    if (t == _i14.StoreSettings) {
      return _i14.StoreSettings.fromJson(data) as T;
    }
    if (t == _i15.UserRole) {
      return _i15.UserRole.fromJson(data) as T;
    }
    if (t == _i16.User) {
      return _i16.User.fromJson(data) as T;
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
    if (t == _i1.getType<_i7.Ingredient?>()) {
      return (data != null ? _i7.Ingredient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.MenuItem?>()) {
      return (data != null ? _i8.MenuItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.OrderItem?>()) {
      return (data != null ? _i9.OrderItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.OrderStatus?>()) {
      return (data != null ? _i10.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.OrderType?>()) {
      return (data != null ? _i11.OrderType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Order?>()) {
      return (data != null ? _i12.Order.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.SelectedOption?>()) {
      return (data != null ? _i13.SelectedOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.StoreSettings?>()) {
      return (data != null ? _i14.StoreSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.UserRole?>()) {
      return (data != null ? _i15.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.User?>()) {
      return (data != null ? _i16.User.fromJson(data) : null) as T;
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
    if (t == List<_i13.SelectedOption>) {
      return (data as List)
              .map((e) => deserialize<_i13.SelectedOption>(e))
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
    if (t == List<_i17.Ingredient>) {
      return (data as List).map((e) => deserialize<_i17.Ingredient>(e)).toList()
          as T;
    }
    if (t == List<_i18.CustomizationGroup>) {
      return (data as List)
              .map((e) => deserialize<_i18.CustomizationGroup>(e))
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
    if (t == List<_i19.MenuItem>) {
      return (data as List).map((e) => deserialize<_i19.MenuItem>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i18.CustomizationGroup>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i18.CustomizationGroup>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i20.User>) {
      return (data as List).map((e) => deserialize<_i20.User>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i20.User>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i20.User>(e)).toList()
              : null)
          as T;
    }
    try {
      return _i21.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i22.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i23.Protocol().deserialize<T>(data, t);
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
      _i7.Ingredient => 'Ingredient',
      _i8.MenuItem => 'MenuItem',
      _i9.OrderItem => 'OrderItem',
      _i10.OrderStatus => 'OrderStatus',
      _i11.OrderType => 'OrderType',
      _i12.Order => 'Order',
      _i13.SelectedOption => 'SelectedOption',
      _i14.StoreSettings => 'StoreSettings',
      _i15.UserRole => 'UserRole',
      _i16.User => 'User',
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
      case _i7.Ingredient():
        return 'Ingredient';
      case _i8.MenuItem():
        return 'MenuItem';
      case _i9.OrderItem():
        return 'OrderItem';
      case _i10.OrderStatus():
        return 'OrderStatus';
      case _i11.OrderType():
        return 'OrderType';
      case _i12.Order():
        return 'Order';
      case _i13.SelectedOption():
        return 'SelectedOption';
      case _i14.StoreSettings():
        return 'StoreSettings';
      case _i15.UserRole():
        return 'UserRole';
      case _i16.User():
        return 'User';
    }
    className = _i21.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i22.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    className = _i23.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'Ingredient') {
      return deserialize<_i7.Ingredient>(data['data']);
    }
    if (dataClassName == 'MenuItem') {
      return deserialize<_i8.MenuItem>(data['data']);
    }
    if (dataClassName == 'OrderItem') {
      return deserialize<_i9.OrderItem>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i10.OrderStatus>(data['data']);
    }
    if (dataClassName == 'OrderType') {
      return deserialize<_i11.OrderType>(data['data']);
    }
    if (dataClassName == 'Order') {
      return deserialize<_i12.Order>(data['data']);
    }
    if (dataClassName == 'SelectedOption') {
      return deserialize<_i13.SelectedOption>(data['data']);
    }
    if (dataClassName == 'StoreSettings') {
      return deserialize<_i14.StoreSettings>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i15.UserRole>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i16.User>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i21.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i22.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i23.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
