import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';

class FcmService {
  static final FcmService _instance = FcmService._();
  static FcmService get instance => _instance;
  FcmService._();

  String? _projectId;
  ServiceAccountCredentials? _credentials;
  bool _initialized = false;

  Future<void> initialize({
    required String? projectId,
    required String? clientEmail,
    required String? privateKey,
    required String? clientId,
  }) async {
    if (projectId == null ||
        clientEmail == null ||
        privateKey == null ||
        clientId == null) {
      print(
        '[FcmService] WARNING: Missing firebase credentials in passwords.yaml. '
        'FCM notifications will not work.',
      );
      return;
    }

    try {
      _projectId = projectId;
      final keyJson = {
        'type': 'service_account',
        'project_id': projectId,
        'private_key': privateKey.replaceAll('\\n', '\n'),
        'client_email': clientEmail,
        'client_id': clientId,
        'token_uri': 'https://oauth2.googleapis.com/token',
      };
      _credentials = ServiceAccountCredentials.fromJson(keyJson);
      _initialized = true;
      print('[FcmService] Initialized with project: $_projectId');
    } catch (e) {
      print('[FcmService] ERROR: Failed to initialize: $e');
    }
  }

  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    Map<String, String>? data,
  }) async {
    if (!_initialized) {
      print('[FcmService] Not initialized — skipping notification');
      return;
    }

    final authClient = await clientViaServiceAccount(
      _credentials!,
      ['https://www.googleapis.com/auth/firebase.messaging'],
    );

    try {
      final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send',
      );

      final message = {
        'message': {
          'token': token,
          'notification': {
            'title': title,
            'body': body,
          },
          if (data != null) 'data': data,
          'android': {
            'priority': 'high',
            'notification': {
              'channel_id': 'login_notifications',
              'sound': 'default',
            },
          },
        },
      };

      final response = await authClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('[FcmService] Notification sent successfully');
      } else {
        print(
          '[FcmService] Failed to send notification: '
          '${response.statusCode} ${response.body}',
        );
      }
    } finally {
      authClient.close();
    }
  }
}
