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
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:pchaa_client/src/protocol/carts.dart' as _i5;
import 'package:pchaa_client/src/protocol/selected_option.dart' as _i6;
import 'package:pchaa_client/src/protocol/ingredient.dart' as _i7;
import 'package:pchaa_client/src/protocol/menu_items.dart' as _i8;
import 'package:pchaa_client/src/protocol/customization_group.dart' as _i9;
import 'package:pchaa_client/src/protocol/menu_item_with_url.dart' as _i10;
import 'package:pchaa_client/src/protocol/available_menu_item.dart' as _i11;
import 'package:pchaa_client/src/protocol/orders.dart' as _i12;
import 'package:pchaa_client/src/protocol/order_type.dart' as _i13;
import 'package:pchaa_client/src/protocol/order_status.dart' as _i14;
import 'package:pchaa_client/src/protocol/order_items.dart' as _i15;
import 'package:pchaa_client/src/protocol/users.dart' as _i16;
import 'package:pchaa_client/src/protocol/user_role.dart' as _i17;
import 'package:pchaa_client/src/protocol/greetings/greeting.dart' as _i18;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i19;
import 'protocol.dart' as _i20;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// {@category Endpoint}
class EndpointCart extends _i2.EndpointRef {
  EndpointCart(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'cart';

  _i3.Future<List<_i5.Cart>> getMyCart() =>
      caller.callServerEndpoint<List<_i5.Cart>>(
        'cart',
        'getMyCart',
        {},
      );

  _i3.Future<_i5.Cart> getCartById(int cartId) =>
      caller.callServerEndpoint<_i5.Cart>(
        'cart',
        'getCartById',
        {'cartId': cartId},
      );

  _i3.Future<_i5.Cart> createCart(
    int menuItemId,
    List<_i6.SelectedOption> selectedOptions,
    int quantity,
    String? additionalMessage,
  ) => caller.callServerEndpoint<_i5.Cart>(
    'cart',
    'createCart',
    {
      'menuItemId': menuItemId,
      'selectedOptions': selectedOptions,
      'quantity': quantity,
      'additionalMessage': additionalMessage,
    },
  );

  _i3.Future<_i5.Cart> updateCart(
    int cartId,
    List<_i6.SelectedOption> selectedOptions,
    int quantity,
    String? additionalMessage,
  ) => caller.callServerEndpoint<_i5.Cart>(
    'cart',
    'updateCart',
    {
      'cartId': cartId,
      'selectedOptions': selectedOptions,
      'quantity': quantity,
      'additionalMessage': additionalMessage,
    },
  );

  _i3.Future<void> deleteCart(int cartId) => caller.callServerEndpoint<void>(
    'cart',
    'deleteCart',
    {'cartId': cartId},
  );

  _i3.Future<void> clearMyCart() => caller.callServerEndpoint<void>(
    'cart',
    'clearMyCart',
    {},
  );

  _i3.Future<void> increaseCartQuantity(int cartId) =>
      caller.callServerEndpoint<void>(
        'cart',
        'increaseCartQuantity',
        {'cartId': cartId},
      );

  _i3.Future<void> decreaseCartQuantity(int cartId) =>
      caller.callServerEndpoint<void>(
        'cart',
        'decreaseCartQuantity',
        {'cartId': cartId},
      );
}

/// {@category Endpoint}
class EndpointIngredient extends _i2.EndpointRef {
  EndpointIngredient(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ingredient';

  _i3.Future<_i7.Ingredient> createIngredient(
    String name,
    bool isAvailable,
  ) => caller.callServerEndpoint<_i7.Ingredient>(
    'ingredient',
    'createIngredient',
    {
      'name': name,
      'isAvailable': isAvailable,
    },
  );

  _i3.Future<List<_i7.Ingredient>> getAllIngredients() =>
      caller.callServerEndpoint<List<_i7.Ingredient>>(
        'ingredient',
        'getAllIngredients',
        {},
      );

  _i3.Future<_i7.Ingredient?> getIngredientById(int id) =>
      caller.callServerEndpoint<_i7.Ingredient?>(
        'ingredient',
        'getIngredientById',
        {'id': id},
      );

  _i3.Future<_i7.Ingredient> updateIngredient(
    int id,
    String? name,
    bool? isAvailable,
  ) => caller.callServerEndpoint<_i7.Ingredient>(
    'ingredient',
    'updateIngredient',
    {
      'id': id,
      'name': name,
      'isAvailable': isAvailable,
    },
  );

  _i3.Future<bool> deleteIngredient(int id) => caller.callServerEndpoint<bool>(
    'ingredient',
    'deleteIngredient',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointMenuItem extends _i2.EndpointRef {
  EndpointMenuItem(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'menuItem';

  _i3.Future<_i8.MenuItem> createMenuItem(
    String name,
    double basePrice,
    int timeToPrepare,
    List<_i9.CustomizationGroup> customization,
    bool isAvailable,
    List<int>? ingredientIds,
    String? imageDataBase64,
    String? imageFileName,
    String? imageContentType,
  ) => caller.callServerEndpoint<_i8.MenuItem>(
    'menuItem',
    'createMenuItem',
    {
      'name': name,
      'basePrice': basePrice,
      'timeToPrepare': timeToPrepare,
      'customization': customization,
      'isAvailable': isAvailable,
      'ingredientIds': ingredientIds,
      'imageDataBase64': imageDataBase64,
      'imageFileName': imageFileName,
      'imageContentType': imageContentType,
    },
  );

  _i3.Future<List<_i10.MenuItemWithUrl>> getAllMenuItems() =>
      caller.callServerEndpoint<List<_i10.MenuItemWithUrl>>(
        'menuItem',
        'getAllMenuItems',
        {},
      );

  _i3.Future<_i10.MenuItemWithUrl?> getMenuItemById(int id) =>
      caller.callServerEndpoint<_i10.MenuItemWithUrl?>(
        'menuItem',
        'getMenuItemById',
        {'id': id},
      );

  _i3.Future<List<_i11.AvailableMenuItem>> getAllAvailableMenuItems() =>
      caller.callServerEndpoint<List<_i11.AvailableMenuItem>>(
        'menuItem',
        'getAllAvailableMenuItems',
        {},
      );

  _i3.Future<_i11.AvailableMenuItem?> getAvailableMenuItemById(int id) =>
      caller.callServerEndpoint<_i11.AvailableMenuItem?>(
        'menuItem',
        'getAvailableMenuItemById',
        {'id': id},
      );

  _i3.Future<_i8.MenuItem> updateMenuItem(
    int id,
    String? name,
    double? basePrice,
    int? timeToPrepare,
    List<_i9.CustomizationGroup>? customization,
    bool? isAvailable,
    List<int>? ingredientIds,
    bool? removeImage,
    String? imageDataBase64,
    String? imageFileName,
    String? imageContentType,
  ) => caller.callServerEndpoint<_i8.MenuItem>(
    'menuItem',
    'updateMenuItem',
    {
      'id': id,
      'name': name,
      'basePrice': basePrice,
      'timeToPrepare': timeToPrepare,
      'customization': customization,
      'isAvailable': isAvailable,
      'ingredientIds': ingredientIds,
      'removeImage': removeImage,
      'imageDataBase64': imageDataBase64,
      'imageFileName': imageFileName,
      'imageContentType': imageContentType,
    },
  );

  _i3.Future<bool> deleteMenuItem(int id) => caller.callServerEndpoint<bool>(
    'menuItem',
    'deleteMenuItem',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointOrder extends _i2.EndpointRef {
  EndpointOrder(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'order';

  _i3.Future<_i12.Order> createOrder(
    String? replyMessage,
    _i13.OrderType orderType,
    DateTime? pickupTime,
  ) => caller.callServerEndpoint<_i12.Order>(
    'order',
    'createOrder',
    {
      'replyMessage': replyMessage,
      'orderType': orderType,
      'pickupTime': pickupTime,
    },
  );

  _i3.Future<_i12.Order> confirmOrder(int orderId) =>
      caller.callServerEndpoint<_i12.Order>(
        'order',
        'confirmOrder',
        {'orderId': orderId},
      );

  _i3.Future<_i12.Order> updateOrderStatus(
    int orderId,
    _i14.OrderStatus newStatus,
  ) => caller.callServerEndpoint<_i12.Order>(
    'order',
    'updateOrderStatus',
    {
      'orderId': orderId,
      'newStatus': newStatus,
    },
  );

  _i3.Future<_i12.Order> cancelMyOrder(int orderId) =>
      caller.callServerEndpoint<_i12.Order>(
        'order',
        'cancelMyOrder',
        {'orderId': orderId},
      );

  _i3.Future<List<_i12.Order>> getMyOrders() =>
      caller.callServerEndpoint<List<_i12.Order>>(
        'order',
        'getMyOrders',
        {},
      );

  _i3.Future<Map<String, int>> getEstimatedQueue() =>
      caller.callServerEndpoint<Map<String, int>>(
        'order',
        'getEstimatedQueue',
        {},
      );

  _i3.Future<Map<String, dynamic>> getOrderById(int orderId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'order',
        'getOrderById',
        {'orderId': orderId},
      );

  _i3.Future<List<_i15.OrderItem>> getOrderItems(int orderId) =>
      caller.callServerEndpoint<List<_i15.OrderItem>>(
        'order',
        'getOrderItems',
        {'orderId': orderId},
      );

  _i3.Future<List<_i12.Order>> getTodayOrder() =>
      caller.callServerEndpoint<List<_i12.Order>>(
        'order',
        'getTodayOrder',
        {},
      );

  _i3.Future<List<_i12.Order>> getFinishedOrders(_i13.OrderType type) =>
      caller.callServerEndpoint<List<_i12.Order>>(
        'order',
        'getFinishedOrders',
        {'type': type},
      );

  _i3.Future<_i12.Order> getTodayOrderByType(_i13.OrderType type) =>
      caller.callServerEndpoint<_i12.Order>(
        'order',
        'getTodayOrderByType',
        {'type': type},
      );

  _i3.Future<List<_i12.Order>> getTodayOrderByStatus(
    _i14.OrderStatus status,
    _i13.OrderType? type,
  ) => caller.callServerEndpoint<List<_i12.Order>>(
    'order',
    'getTodayOrderByStatus',
    {
      'status': status,
      'type': type,
    },
  );
}

/// {@category Endpoint}
class EndpointQueue extends _i2.EndpointRef {
  EndpointQueue(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'queue';

  _i3.Future<Map<String, int>> getQueueCounters() =>
      caller.callServerEndpoint<Map<String, int>>(
        'queue',
        'getQueueCounters',
        {},
      );
}

/// {@category Endpoint}
class EndpointUser extends _i2.EndpointRef {
  EndpointUser(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i3.Future<_i16.User?> registerUser({String? profilePictureUrl}) =>
      caller.callServerEndpoint<_i16.User?>(
        'user',
        'registerUser',
        {'profilePictureUrl': profilePictureUrl},
      );

  _i3.Future<_i16.User?> getCurrentUser() =>
      caller.callServerEndpoint<_i16.User?>(
        'user',
        'getCurrentUser',
        {},
      );

  _i3.Future<List<_i16.User>?> getAllUser() =>
      caller.callServerEndpoint<List<_i16.User>?>(
        'user',
        'getAllUser',
        {},
      );

  _i3.Future<_i16.User> updateUserRole(
    int userId,
    _i17.UserRole newRole,
  ) => caller.callServerEndpoint<_i16.User>(
    'user',
    'updateUserRole',
    {
      'userId': userId,
      'newRole': newRole,
    },
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i2.EndpointRef {
  EndpointGreeting(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i3.Future<_i18.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i18.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    auth = _i19.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i19.Caller auth;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i20.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    cart = EndpointCart(this);
    ingredient = EndpointIngredient(this);
    menuItem = EndpointMenuItem(this);
    order = EndpointOrder(this);
    queue = EndpointQueue(this);
    user = EndpointUser(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointCart cart;

  late final EndpointIngredient ingredient;

  late final EndpointMenuItem menuItem;

  late final EndpointOrder order;

  late final EndpointQueue queue;

  late final EndpointUser user;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'cart': cart,
    'ingredient': ingredient,
    'menuItem': menuItem,
    'order': order,
    'queue': queue,
    'user': user,
    'greeting': greeting,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'auth': modules.auth,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
