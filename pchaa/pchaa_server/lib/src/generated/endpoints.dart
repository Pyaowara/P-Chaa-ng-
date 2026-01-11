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
import '../endpoints/order_endpoint.dart' as _i7;
import '../endpoints/queue_endpoint.dart' as _i8;
import '../endpoints/user_endpoint.dart' as _i9;
import '../greetings/greeting_endpoint.dart' as _i10;
import 'package:pchaa_server/src/generated/selected_option.dart' as _i11;
import 'package:pchaa_server/src/generated/customization_group.dart' as _i12;
import 'package:pchaa_server/src/generated/order_type.dart' as _i13;
import 'package:pchaa_server/src/generated/order_status.dart' as _i14;
import 'package:pchaa_server/src/generated/user_role.dart' as _i15;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i16;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i17;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i18;

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
      'order': _i7.OrderEndpoint()
        ..initialize(
          server,
          'order',
          null,
        ),
      'queue': _i8.QueueEndpoint()
        ..initialize(
          server,
          'queue',
          null,
        ),
      'user': _i9.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
      'greeting': _i10.GreetingEndpoint()
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
              type: _i1.getType<List<_i11.SelectedOption>>(),
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
              type: _i1.getType<List<_i11.SelectedOption>>(),
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
        'increaseCartQuantity': _i1.MethodConnector(
          name: 'increaseCartQuantity',
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
              ) async =>
                  (endpoints['cart'] as _i4.CartEndpoint).increaseCartQuantity(
                    session,
                    params['cartId'],
                  ),
        ),
        'decreaseCartQuantity': _i1.MethodConnector(
          name: 'decreaseCartQuantity',
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
              ) async =>
                  (endpoints['cart'] as _i4.CartEndpoint).decreaseCartQuantity(
                    session,
                    params['cartId'],
                  ),
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
              type: _i1.getType<List<_i12.CustomizationGroup>>(),
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
              type: _i1.getType<List<_i12.CustomizationGroup>?>(),
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
              type: _i1.getType<_i13.OrderType>(),
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
              ) async => (endpoints['order'] as _i7.OrderEndpoint).createOrder(
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
              ) async => (endpoints['order'] as _i7.OrderEndpoint).confirmOrder(
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
              type: _i1.getType<_i14.OrderStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i7.OrderEndpoint).updateOrderStatus(
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
                  (endpoints['order'] as _i7.OrderEndpoint).cancelMyOrder(
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
              ) async => (endpoints['order'] as _i7.OrderEndpoint).getMyOrders(
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
              ) async => (endpoints['order'] as _i7.OrderEndpoint)
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
              ) async => (endpoints['order'] as _i7.OrderEndpoint).getOrderById(
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
                  (endpoints['order'] as _i7.OrderEndpoint).getOrderItems(
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
              ) async => (endpoints['order'] as _i7.OrderEndpoint)
                  .getTodayOrder(session),
        ),
        'getFinishedOrders': _i1.MethodConnector(
          name: 'getFinishedOrders',
          params: {
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i13.OrderType>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i7.OrderEndpoint).getFinishedOrders(
                    session,
                    params['type'],
                  ),
        ),
        'getTodayOrderByType': _i1.MethodConnector(
          name: 'getTodayOrderByType',
          params: {
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i13.OrderType>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i7.OrderEndpoint).getTodayOrderByType(
                    session,
                    params['type'],
                  ),
        ),
        'getTodayOrderByStatus': _i1.MethodConnector(
          name: 'getTodayOrderByStatus',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i14.OrderStatus>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i13.OrderType?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i7.OrderEndpoint)
                  .getTodayOrderByStatus(
                    session,
                    params['status'],
                    params['type'],
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
              ) async => (endpoints['queue'] as _i8.QueueEndpoint)
                  .getQueueCounters(session),
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
              ) async => (endpoints['user'] as _i9.UserEndpoint).registerUser(
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
              ) async => (endpoints['user'] as _i9.UserEndpoint).getCurrentUser(
                session,
              ),
        ),
        'getAllUser': _i1.MethodConnector(
          name: 'getAllUser',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i9.UserEndpoint).getAllUser(session),
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
              type: _i1.getType<_i15.UserRole>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i9.UserEndpoint).updateUserRole(
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
              ) async => (endpoints['greeting'] as _i10.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i16.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth'] = _i17.Endpoints()..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i18.Endpoints()
      ..initializeEndpoints(server);
  }
}
