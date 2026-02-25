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
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../endpoints/cart_endpoint.dart' as _i4;
import '../endpoints/ingredient_endpoint.dart' as _i5;
import '../endpoints/menu_item_endpoint.dart' as _i6;
import '../endpoints/notification_endpoint.dart' as _i7;
import '../endpoints/order_endpoint.dart' as _i8;
import '../endpoints/queue_endpoint.dart' as _i9;
import '../endpoints/store_endpoint.dart' as _i10;
import '../endpoints/user_endpoint.dart' as _i11;
import '../greetings/greeting_endpoint.dart' as _i12;
import 'package:pchaa_server/src/generated/selected_option.dart' as _i13;
import 'package:pchaa_server/src/generated/customization_group.dart' as _i14;
import 'package:pchaa_server/src/generated/order_type.dart' as _i15;
import 'package:pchaa_server/src/generated/order_status.dart' as _i16;
import 'package:pchaa_server/src/generated/store_settings.dart' as _i17;
import 'package:pchaa_server/src/generated/user_role.dart' as _i18;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i19;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i20;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i21;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'cart': _i4.CartEndpoint()
        ..initialize(
          server,
          'cart',
          null,
        ),
      'ingredient': _i5.IngredientEndpoint()
        ..initialize(
          server,
          'ingredient',
          null,
        ),
      'menuItem': _i6.MenuItemEndpoint()
        ..initialize(
          server,
          'menuItem',
          null,
        ),
      'notification': _i7.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'order': _i8.OrderEndpoint()
        ..initialize(
          server,
          'order',
          null,
        ),
      'queue': _i9.QueueEndpoint()
        ..initialize(
          server,
          'queue',
          null,
        ),
      'store': _i10.StoreEndpoint()
        ..initialize(
          server,
          'store',
          null,
        ),
      'user': _i11.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
      'greeting': _i12.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['cart'] = _i1.EndpointConnector(
      name: 'cart',
      endpoint: endpoints['cart']!,
      methodConnectors: {
        'getMyCart': _i1.MethodConnector(
          name: 'getMyCart',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['cart'] as _i4.CartEndpoint).getMyCart(session),
        ),
        'getCartById': _i1.MethodConnector(
          name: 'getCartById',
          params: {
            'cartId': _i1.ParameterDescription(
              name: 'cartId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['cart'] as _i4.CartEndpoint).getCartById(
                session,
                params['cartId'],
              ),
        ),
        'createCart': _i1.MethodConnector(
          name: 'createCart',
          params: {
            'menuItemId': _i1.ParameterDescription(
              name: 'menuItemId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'selectedOptions': _i1.ParameterDescription(
              name: 'selectedOptions',
              type: _i1.getType<List<_i13.SelectedOption>>(),
              nullable: false,
            ),
            'quantity': _i1.ParameterDescription(
              name: 'quantity',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'additionalMessage': _i1.ParameterDescription(
              name: 'additionalMessage',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['cart'] as _i4.CartEndpoint).createCart(
                session,
                params['menuItemId'],
                params['selectedOptions'],
                params['quantity'],
                params['additionalMessage'],
              ),
        ),
        'updateCart': _i1.MethodConnector(
          name: 'updateCart',
          params: {
            'cartId': _i1.ParameterDescription(
              name: 'cartId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'selectedOptions': _i1.ParameterDescription(
              name: 'selectedOptions',
              type: _i1.getType<List<_i13.SelectedOption>>(),
              nullable: false,
            ),
            'quantity': _i1.ParameterDescription(
              name: 'quantity',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'additionalMessage': _i1.ParameterDescription(
              name: 'additionalMessage',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['cart'] as _i4.CartEndpoint).updateCart(
                session,
                params['cartId'],
                params['selectedOptions'],
                params['quantity'],
                params['additionalMessage'],
              ),
        ),
        'deleteCart': _i1.MethodConnector(
          name: 'deleteCart',
          params: {
            'cartId': _i1.ParameterDescription(
              name: 'cartId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['cart'] as _i4.CartEndpoint).deleteCart(
                session,
                params['cartId'],
              ),
        ),
        'clearMyCart': _i1.MethodConnector(
          name: 'clearMyCart',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['cart'] as _i4.CartEndpoint).clearMyCart(session),
        ),
      },
    );
    connectors['ingredient'] = _i1.EndpointConnector(
      name: 'ingredient',
      endpoint: endpoints['ingredient']!,
      methodConnectors: {
        'createIngredient': _i1.MethodConnector(
          name: 'createIngredient',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isAvailable': _i1.ParameterDescription(
              name: 'isAvailable',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ingredient'] as _i5.IngredientEndpoint)
                  .createIngredient(
                    session,
                    params['name'],
                    params['isAvailable'],
                  ),
        ),
        'getAllIngredients': _i1.MethodConnector(
          name: 'getAllIngredients',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ingredient'] as _i5.IngredientEndpoint)
                  .getAllIngredients(session),
        ),
        'getIngredientById': _i1.MethodConnector(
          name: 'getIngredientById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ingredient'] as _i5.IngredientEndpoint)
                  .getIngredientById(
                    session,
                    params['id'],
                  ),
        ),
        'updateIngredient': _i1.MethodConnector(
          name: 'updateIngredient',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isAvailable': _i1.ParameterDescription(
              name: 'isAvailable',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ingredient'] as _i5.IngredientEndpoint)
                  .updateIngredient(
                    session,
                    params['id'],
                    params['name'],
                    params['isAvailable'],
                  ),
        ),
        'deleteIngredient': _i1.MethodConnector(
          name: 'deleteIngredient',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ingredient'] as _i5.IngredientEndpoint)
                  .deleteIngredient(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['menuItem'] = _i1.EndpointConnector(
      name: 'menuItem',
      endpoint: endpoints['menuItem']!,
      methodConnectors: {
        'createMenuItem': _i1.MethodConnector(
          name: 'createMenuItem',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'basePrice': _i1.ParameterDescription(
              name: 'basePrice',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'timeToPrepare': _i1.ParameterDescription(
              name: 'timeToPrepare',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'customization': _i1.ParameterDescription(
              name: 'customization',
              type: _i1.getType<List<_i14.CustomizationGroup>>(),
              nullable: false,
            ),
            'isAvailable': _i1.ParameterDescription(
              name: 'isAvailable',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'ingredientIds': _i1.ParameterDescription(
              name: 'ingredientIds',
              type: _i1.getType<List<int>?>(),
              nullable: true,
            ),
            'imageDataBase64': _i1.ParameterDescription(
              name: 'imageDataBase64',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageFileName': _i1.ParameterDescription(
              name: 'imageFileName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageContentType': _i1.ParameterDescription(
              name: 'imageContentType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menuItem'] as _i6.MenuItemEndpoint)
                  .createMenuItem(
                    session,
                    params['name'],
                    params['basePrice'],
                    params['timeToPrepare'],
                    params['customization'],
                    params['isAvailable'],
                    params['ingredientIds'],
                    params['imageDataBase64'],
                    params['imageFileName'],
                    params['imageContentType'],
                  ),
        ),
        'getAllMenuItems': _i1.MethodConnector(
          name: 'getAllMenuItems',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menuItem'] as _i6.MenuItemEndpoint)
                  .getAllMenuItems(session),
        ),
        'getMenuItemById': _i1.MethodConnector(
          name: 'getMenuItemById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menuItem'] as _i6.MenuItemEndpoint)
                  .getMenuItemById(
                    session,
                    params['id'],
                  ),
        ),
        'getAllAvailableMenuItems': _i1.MethodConnector(
          name: 'getAllAvailableMenuItems',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menuItem'] as _i6.MenuItemEndpoint)
                  .getAllAvailableMenuItems(session),
        ),
        'getAvailableMenuItemById': _i1.MethodConnector(
          name: 'getAvailableMenuItemById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menuItem'] as _i6.MenuItemEndpoint)
                  .getAvailableMenuItemById(
                    session,
                    params['id'],
                  ),
        ),
        'updateMenuItem': _i1.MethodConnector(
          name: 'updateMenuItem',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'basePrice': _i1.ParameterDescription(
              name: 'basePrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'timeToPrepare': _i1.ParameterDescription(
              name: 'timeToPrepare',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'customization': _i1.ParameterDescription(
              name: 'customization',
              type: _i1.getType<List<_i14.CustomizationGroup>?>(),
              nullable: true,
            ),
            'isAvailable': _i1.ParameterDescription(
              name: 'isAvailable',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'ingredientIds': _i1.ParameterDescription(
              name: 'ingredientIds',
              type: _i1.getType<List<int>?>(),
              nullable: true,
            ),
            'removeImage': _i1.ParameterDescription(
              name: 'removeImage',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'imageDataBase64': _i1.ParameterDescription(
              name: 'imageDataBase64',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageFileName': _i1.ParameterDescription(
              name: 'imageFileName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageContentType': _i1.ParameterDescription(
              name: 'imageContentType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menuItem'] as _i6.MenuItemEndpoint)
                  .updateMenuItem(
                    session,
                    params['id'],
                    params['name'],
                    params['basePrice'],
                    params['timeToPrepare'],
                    params['customization'],
                    params['isAvailable'],
                    params['ingredientIds'],
                    params['removeImage'],
                    params['imageDataBase64'],
                    params['imageFileName'],
                    params['imageContentType'],
                  ),
        ),
        'deleteMenuItem': _i1.MethodConnector(
          name: 'deleteMenuItem',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menuItem'] as _i6.MenuItemEndpoint)
                  .deleteMenuItem(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['notification'] = _i1.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'registerToken': _i1.MethodConnector(
          name: 'registerToken',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'deviceInfo': _i1.ParameterDescription(
              name: 'deviceInfo',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['notification'] as _i7.NotificationEndpoint)
                  .registerToken(
                    session,
                    params['token'],
                    deviceInfo: params['deviceInfo'],
                  ),
        ),
        'removeToken': _i1.MethodConnector(
          name: 'removeToken',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['notification'] as _i7.NotificationEndpoint)
                  .removeToken(
                    session,
                    params['token'],
                  ),
        ),
        'sendLoginNotification': _i1.MethodConnector(
          name: 'sendLoginNotification',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['notification'] as _i7.NotificationEndpoint)
                  .sendLoginNotification(session),
        ),
      },
    );
    connectors['order'] = _i1.EndpointConnector(
      name: 'order',
      endpoint: endpoints['order']!,
      methodConnectors: {
        'createOrder': _i1.MethodConnector(
          name: 'createOrder',
          params: {
            'replyMessage': _i1.ParameterDescription(
              name: 'replyMessage',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'orderType': _i1.ParameterDescription(
              name: 'orderType',
              type: _i1.getType<_i15.OrderType>(),
              nullable: false,
            ),
            'pickupTime': _i1.ParameterDescription(
              name: 'pickupTime',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i8.OrderEndpoint).createOrder(
                session,
                params['replyMessage'],
                params['orderType'],
                params['pickupTime'],
              ),
        ),
        'confirmOrder': _i1.MethodConnector(
          name: 'confirmOrder',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i8.OrderEndpoint).confirmOrder(
                session,
                params['orderId'],
              ),
        ),
        'updateOrderStatus': _i1.MethodConnector(
          name: 'updateOrderStatus',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newStatus': _i1.ParameterDescription(
              name: 'newStatus',
              type: _i1.getType<_i16.OrderStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i8.OrderEndpoint).updateOrderStatus(
                    session,
                    params['orderId'],
                    params['newStatus'],
                  ),
        ),
        'cancelMyOrder': _i1.MethodConnector(
          name: 'cancelMyOrder',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i8.OrderEndpoint).cancelMyOrder(
                    session,
                    params['orderId'],
                  ),
        ),
        'getMyOrders': _i1.MethodConnector(
          name: 'getMyOrders',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i8.OrderEndpoint).getMyOrders(
                session,
              ),
        ),
        'getEstimatedQueue': _i1.MethodConnector(
          name: 'getEstimatedQueue',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i8.OrderEndpoint)
                  .getEstimatedQueue(session),
        ),
        'getOrderById': _i1.MethodConnector(
          name: 'getOrderById',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i8.OrderEndpoint).getOrderById(
                session,
                params['orderId'],
              ),
        ),
        'getOrderItems': _i1.MethodConnector(
          name: 'getOrderItems',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i8.OrderEndpoint).getOrderItems(
                    session,
                    params['orderId'],
                  ),
        ),
        'getTodayOrder': _i1.MethodConnector(
          name: 'getTodayOrder',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i8.OrderEndpoint)
                  .getTodayOrder(session),
        ),
        'getFinishedOrders': _i1.MethodConnector(
          name: 'getFinishedOrders',
          params: {
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i15.OrderType?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i8.OrderEndpoint).getFinishedOrders(
                    session,
                    params['type'],
                  ),
        ),
        'getTodayOrderByType': _i1.MethodConnector(
          name: 'getTodayOrderByType',
          params: {
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i15.OrderType>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i16.OrderStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i8.OrderEndpoint).getTodayOrderByType(
                    session,
                    params['type'],
                    params['status'],
                  ),
        ),
      },
    );
    connectors['queue'] = _i1.EndpointConnector(
      name: 'queue',
      endpoint: endpoints['queue']!,
      methodConnectors: {
        'getQueueCounters': _i1.MethodConnector(
          name: 'getQueueCounters',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['queue'] as _i9.QueueEndpoint)
                  .getQueueCounters(session),
        ),
      },
    );
    connectors['store'] = _i1.EndpointConnector(
      name: 'store',
      endpoint: endpoints['store']!,
      methodConnectors: {
        'getStoreSettings': _i1.MethodConnector(
          name: 'getStoreSettings',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['store'] as _i10.StoreEndpoint)
                  .getStoreSettings(session),
        ),
        'updateStoreStatus': _i1.MethodConnector(
          name: 'updateStoreStatus',
          params: {
            'isOpen': _i1.ParameterDescription(
              name: 'isOpen',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i10.StoreEndpoint).updateStoreStatus(
                    session,
                    params['isOpen'],
                  ),
        ),
        'updateStoreSettings': _i1.MethodConnector(
          name: 'updateStoreSettings',
          params: {
            'storeSettings': _i1.ParameterDescription(
              name: 'storeSettings',
              type: _i1.getType<_i17.StoreSettings>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['store'] as _i10.StoreEndpoint)
                  .updateStoreSettings(
                    session,
                    params['storeSettings'],
                  ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'registerUser': _i1.MethodConnector(
          name: 'registerUser',
          params: {
            'profilePictureUrl': _i1.ParameterDescription(
              name: 'profilePictureUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i11.UserEndpoint).registerUser(
                session,
                profilePictureUrl: params['profilePictureUrl'],
              ),
        ),
        'getCurrentUser': _i1.MethodConnector(
          name: 'getCurrentUser',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i11.UserEndpoint)
                  .getCurrentUser(session),
        ),
        'getAllUser': _i1.MethodConnector(
          name: 'getAllUser',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i11.UserEndpoint).getAllUser(session),
        ),
        'updateUserRole': _i1.MethodConnector(
          name: 'updateUserRole',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newRole': _i1.ParameterDescription(
              name: 'newRole',
              type: _i1.getType<_i18.UserRole>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i11.UserEndpoint).updateUserRole(
                    session,
                    params['userId'],
                    params['newRole'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i12.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i19.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth'] = _i20.Endpoints()..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i21.Endpoints()
      ..initializeEndpoints(server);
  }
}
