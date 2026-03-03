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
import 'available_add_on_option.dart' as _i3;
import 'available_customization_group.dart' as _i4;
import 'available_menu_item.dart' as _i5;
import 'cart_detail.dart' as _i6;
import 'carts.dart' as _i7;
import 'customization_group.dart' as _i8;
import 'daily_queue_counters.dart' as _i9;
import 'fcm_token.dart' as _i10;
import 'greetings/greeting.dart' as _i11;
import 'ingredient.dart' as _i12;
import 'menu_item_with_url.dart' as _i13;
import 'menu_items.dart' as _i14;
import 'order_items.dart' as _i15;
import 'order_status.dart' as _i16;
import 'order_type.dart' as _i17;
import 'order_with_user_name.dart' as _i18;
import 'orders.dart' as _i19;
import 'selected_option.dart' as _i20;
import 'store_settings.dart' as _i21;
import 'user_role.dart' as _i22;
import 'users.dart' as _i23;
import 'package:pchaa_client/src/protocol/cart_detail.dart' as _i24;
import 'package:pchaa_client/src/protocol/selected_option.dart' as _i25;
import 'package:pchaa_client/src/protocol/ingredient.dart' as _i26;
import 'package:pchaa_client/src/protocol/customization_group.dart' as _i27;
import 'package:pchaa_client/src/protocol/menu_item_with_url.dart' as _i28;
import 'package:pchaa_client/src/protocol/available_menu_item.dart' as _i29;
import 'package:pchaa_client/src/protocol/orders.dart' as _i30;
import 'package:pchaa_client/src/protocol/order_items.dart' as _i31;
import 'package:pchaa_client/src/protocol/order_with_user_name.dart' as _i32;
import 'package:pchaa_client/src/protocol/users.dart' as _i33;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i34;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i35;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i36;
export 'add_on_option.dart';
export 'available_add_on_option.dart';
export 'available_customization_group.dart';
export 'available_menu_item.dart';
export 'cart_detail.dart';
export 'carts.dart';
export 'customization_group.dart';
export 'daily_queue_counters.dart';
export 'fcm_token.dart';
export 'greetings/greeting.dart';
export 'ingredient.dart';
export 'menu_item_with_url.dart';
export 'menu_items.dart';
export 'order_items.dart';
export 'order_status.dart';
export 'order_type.dart';
export 'order_with_user_name.dart';
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
    if (t == _i3.AvailableAddOnOption) {
      return _i3.AvailableAddOnOption.fromJson(data) as T;
    }
    if (t == _i4.AvailableCustomizationGroup) {
      return _i4.AvailableCustomizationGroup.fromJson(data) as T;
    }
    if (t == _i5.AvailableMenuItem) {
      return _i5.AvailableMenuItem.fromJson(data) as T;
    }
    if (t == _i6.CartDetail) {
      return _i6.CartDetail.fromJson(data) as T;
    }
    if (t == _i7.Cart) {
      return _i7.Cart.fromJson(data) as T;
    }
    if (t == _i8.CustomizationGroup) {
      return _i8.CustomizationGroup.fromJson(data) as T;
    }
    if (t == _i9.DailyQueueCounter) {
      return _i9.DailyQueueCounter.fromJson(data) as T;
    }
    if (t == _i10.FcmToken) {
      return _i10.FcmToken.fromJson(data) as T;
    }
    if (t == _i11.Greeting) {
      return _i11.Greeting.fromJson(data) as T;
    }
    if (t == _i12.Ingredient) {
      return _i12.Ingredient.fromJson(data) as T;
    }
    if (t == _i13.MenuItemWithUrl) {
      return _i13.MenuItemWithUrl.fromJson(data) as T;
    }
    if (t == _i14.MenuItem) {
      return _i14.MenuItem.fromJson(data) as T;
    }
    if (t == _i15.OrderItem) {
      return _i15.OrderItem.fromJson(data) as T;
    }
    if (t == _i16.OrderStatus) {
      return _i16.OrderStatus.fromJson(data) as T;
    }
    if (t == _i17.OrderType) {
      return _i17.OrderType.fromJson(data) as T;
    }
    if (t == _i18.OrderWithUserName) {
      return _i18.OrderWithUserName.fromJson(data) as T;
    }
    if (t == _i19.Order) {
      return _i19.Order.fromJson(data) as T;
    }
    if (t == _i20.SelectedOption) {
      return _i20.SelectedOption.fromJson(data) as T;
    }
    if (t == _i21.StoreSettings) {
      return _i21.StoreSettings.fromJson(data) as T;
    }
    if (t == _i22.UserRole) {
      return _i22.UserRole.fromJson(data) as T;
    }
    if (t == _i23.User) {
      return _i23.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AddOnOption?>()) {
      return (data != null ? _i2.AddOnOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AvailableAddOnOption?>()) {
      return (data != null ? _i3.AvailableAddOnOption.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.AvailableCustomizationGroup?>()) {
      return (data != null
              ? _i4.AvailableCustomizationGroup.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i5.AvailableMenuItem?>()) {
      return (data != null ? _i5.AvailableMenuItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.CartDetail?>()) {
      return (data != null ? _i6.CartDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Cart?>()) {
      return (data != null ? _i7.Cart.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CustomizationGroup?>()) {
      return (data != null ? _i8.CustomizationGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.DailyQueueCounter?>()) {
      return (data != null ? _i9.DailyQueueCounter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.FcmToken?>()) {
      return (data != null ? _i10.FcmToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Greeting?>()) {
      return (data != null ? _i11.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Ingredient?>()) {
      return (data != null ? _i12.Ingredient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.MenuItemWithUrl?>()) {
      return (data != null ? _i13.MenuItemWithUrl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.MenuItem?>()) {
      return (data != null ? _i14.MenuItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.OrderItem?>()) {
      return (data != null ? _i15.OrderItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.OrderStatus?>()) {
      return (data != null ? _i16.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.OrderType?>()) {
      return (data != null ? _i17.OrderType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.OrderWithUserName?>()) {
      return (data != null ? _i18.OrderWithUserName.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.Order?>()) {
      return (data != null ? _i19.Order.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.SelectedOption?>()) {
      return (data != null ? _i20.SelectedOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.StoreSettings?>()) {
      return (data != null ? _i21.StoreSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.UserRole?>()) {
      return (data != null ? _i22.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.User?>()) {
      return (data != null ? _i23.User.fromJson(data) : null) as T;
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
    if (t == List<_i3.AvailableAddOnOption>) {
      return (data as List)
              .map((e) => deserialize<_i3.AvailableAddOnOption>(e))
              .toList()
          as T;
    }
    if (t == List<_i4.AvailableCustomizationGroup>) {
      return (data as List)
              .map((e) => deserialize<_i4.AvailableCustomizationGroup>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.SelectedOption>) {
      return (data as List)
              .map((e) => deserialize<_i20.SelectedOption>(e))
              .toList()
          as T;
    }
    if (t == List<_i2.AddOnOption>) {
      return (data as List).map((e) => deserialize<_i2.AddOnOption>(e)).toList()
          as T;
    }
    if (t == List<_i8.CustomizationGroup>) {
      return (data as List)
              .map((e) => deserialize<_i8.CustomizationGroup>(e))
              .toList()
          as T;
    }
    if (t == List<_i24.CartDetail>) {
      return (data as List).map((e) => deserialize<_i24.CartDetail>(e)).toList()
          as T;
    }
    if (t == List<_i25.SelectedOption>) {
      return (data as List)
              .map((e) => deserialize<_i25.SelectedOption>(e))
              .toList()
          as T;
    }
    if (t == List<_i26.Ingredient>) {
      return (data as List).map((e) => deserialize<_i26.Ingredient>(e)).toList()
          as T;
    }
    if (t == List<_i27.CustomizationGroup>) {
      return (data as List)
              .map((e) => deserialize<_i27.CustomizationGroup>(e))
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
    if (t == List<_i28.MenuItemWithUrl>) {
      return (data as List)
              .map((e) => deserialize<_i28.MenuItemWithUrl>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.AvailableMenuItem>) {
      return (data as List)
              .map((e) => deserialize<_i29.AvailableMenuItem>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i27.CustomizationGroup>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i27.CustomizationGroup>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i30.Order>) {
      return (data as List).map((e) => deserialize<_i30.Order>(e)).toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == List<_i31.OrderItem>) {
      return (data as List).map((e) => deserialize<_i31.OrderItem>(e)).toList()
          as T;
    }
    if (t == List<_i32.OrderWithUserName>) {
      return (data as List)
              .map((e) => deserialize<_i32.OrderWithUserName>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.User>) {
      return (data as List).map((e) => deserialize<_i33.User>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i33.User>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i33.User>(e)).toList()
              : null)
          as T;
    }
    try {
      return _i34.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i35.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i36.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AddOnOption => 'AddOnOption',
      _i3.AvailableAddOnOption => 'AvailableAddOnOption',
      _i4.AvailableCustomizationGroup => 'AvailableCustomizationGroup',
      _i5.AvailableMenuItem => 'AvailableMenuItem',
      _i6.CartDetail => 'CartDetail',
      _i7.Cart => 'Cart',
      _i8.CustomizationGroup => 'CustomizationGroup',
      _i9.DailyQueueCounter => 'DailyQueueCounter',
      _i10.FcmToken => 'FcmToken',
      _i11.Greeting => 'Greeting',
      _i12.Ingredient => 'Ingredient',
      _i13.MenuItemWithUrl => 'MenuItemWithUrl',
      _i14.MenuItem => 'MenuItem',
      _i15.OrderItem => 'OrderItem',
      _i16.OrderStatus => 'OrderStatus',
      _i17.OrderType => 'OrderType',
      _i18.OrderWithUserName => 'OrderWithUserName',
      _i19.Order => 'Order',
      _i20.SelectedOption => 'SelectedOption',
      _i21.StoreSettings => 'StoreSettings',
      _i22.UserRole => 'UserRole',
      _i23.User => 'User',
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
      case _i3.AvailableAddOnOption():
        return 'AvailableAddOnOption';
      case _i4.AvailableCustomizationGroup():
        return 'AvailableCustomizationGroup';
      case _i5.AvailableMenuItem():
        return 'AvailableMenuItem';
      case _i6.CartDetail():
        return 'CartDetail';
      case _i7.Cart():
        return 'Cart';
      case _i8.CustomizationGroup():
        return 'CustomizationGroup';
      case _i9.DailyQueueCounter():
        return 'DailyQueueCounter';
      case _i10.FcmToken():
        return 'FcmToken';
      case _i11.Greeting():
        return 'Greeting';
      case _i12.Ingredient():
        return 'Ingredient';
      case _i13.MenuItemWithUrl():
        return 'MenuItemWithUrl';
      case _i14.MenuItem():
        return 'MenuItem';
      case _i15.OrderItem():
        return 'OrderItem';
      case _i16.OrderStatus():
        return 'OrderStatus';
      case _i17.OrderType():
        return 'OrderType';
      case _i18.OrderWithUserName():
        return 'OrderWithUserName';
      case _i19.Order():
        return 'Order';
      case _i20.SelectedOption():
        return 'SelectedOption';
      case _i21.StoreSettings():
        return 'StoreSettings';
      case _i22.UserRole():
        return 'UserRole';
      case _i23.User():
        return 'User';
    }
    className = _i34.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i35.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    className = _i36.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AvailableAddOnOption') {
      return deserialize<_i3.AvailableAddOnOption>(data['data']);
    }
    if (dataClassName == 'AvailableCustomizationGroup') {
      return deserialize<_i4.AvailableCustomizationGroup>(data['data']);
    }
    if (dataClassName == 'AvailableMenuItem') {
      return deserialize<_i5.AvailableMenuItem>(data['data']);
    }
    if (dataClassName == 'CartDetail') {
      return deserialize<_i6.CartDetail>(data['data']);
    }
    if (dataClassName == 'Cart') {
      return deserialize<_i7.Cart>(data['data']);
    }
    if (dataClassName == 'CustomizationGroup') {
      return deserialize<_i8.CustomizationGroup>(data['data']);
    }
    if (dataClassName == 'DailyQueueCounter') {
      return deserialize<_i9.DailyQueueCounter>(data['data']);
    }
    if (dataClassName == 'FcmToken') {
      return deserialize<_i10.FcmToken>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i11.Greeting>(data['data']);
    }
    if (dataClassName == 'Ingredient') {
      return deserialize<_i12.Ingredient>(data['data']);
    }
    if (dataClassName == 'MenuItemWithUrl') {
      return deserialize<_i13.MenuItemWithUrl>(data['data']);
    }
    if (dataClassName == 'MenuItem') {
      return deserialize<_i14.MenuItem>(data['data']);
    }
    if (dataClassName == 'OrderItem') {
      return deserialize<_i15.OrderItem>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i16.OrderStatus>(data['data']);
    }
    if (dataClassName == 'OrderType') {
      return deserialize<_i17.OrderType>(data['data']);
    }
    if (dataClassName == 'OrderWithUserName') {
      return deserialize<_i18.OrderWithUserName>(data['data']);
    }
    if (dataClassName == 'Order') {
      return deserialize<_i19.Order>(data['data']);
    }
    if (dataClassName == 'SelectedOption') {
      return deserialize<_i20.SelectedOption>(data['data']);
    }
    if (dataClassName == 'StoreSettings') {
      return deserialize<_i21.StoreSettings>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i22.UserRole>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i23.User>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i34.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i35.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i36.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
