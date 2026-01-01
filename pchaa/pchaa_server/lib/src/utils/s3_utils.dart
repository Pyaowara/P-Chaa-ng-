import 'package:minio/minio.dart';
import 'package:minio/models.dart';
import 'package:serverpod/serverpod.dart';
import 'dart:typed_data';
import 'dart:io';

class S3Utils {
  static Minio? _minio;
  static String? _menuBucket;
  static String? _storeBucket;
  static String? _endpoint;
  static int? _port;

  static Minio _getClient(Session session) {
    if (_minio != null) return _minio!;

    _endpoint = Platform.environment['MINIO_ENDPOINT'] ?? 'localhost';
    _port = int.tryParse(Platform.environment['MINIO_PORT'] ?? '8092') ?? 8092;
    final useSSL = Platform.environment['MINIO_USE_SSL'] == 'true';
    _menuBucket = Platform.environment['MINIO_MENU_BUCKET'] ?? 'menu-items';
    _storeBucket = Platform.environment['MINIO_STORE_BUCKET'] ?? 'store-images';

    final accessKey = session.passwords['minio_access_key'] ?? 'minioadmin';
    final secretKey = session.passwords['minio_secret_key'] ?? 'minioadmin';

    _minio = Minio(
      endPoint: _endpoint!,
      port: _port,
      useSSL: useSSL,
      accessKey: accessKey,
      secretKey: secretKey,
    );

    return _minio!;
  }

  static Future<void> ensureBucketExists(
    Session session,
    String bucketName,
  ) async {
    final minio = _getClient(session);

    final exists = await minio.bucketExists(bucketName);
    if (!exists) {
      await minio.makeBucket(bucketName);

      final policy = {
        'Version': '2012-10-17',
        'Statement': [
          {
            'Effect': 'Allow',
            'Principal': {
              'AWS': ['*'],
            },
            'Action': ['s3:GetObject'],
            'Resource': ['arn:aws:s3:::$bucketName/*'],
          },
        ],
      };

      await minio.setBucketPolicy(bucketName, policy);
    }
  }

  static Future<String> uploadImage(
    Session session,
    String bucketName,
    String fileName,
    Uint8List imageData,
    String contentType,
  ) async {
    final minio = _getClient(session);
    await ensureBucketExists(session, bucketName);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final s3Key = '$timestamp-$fileName';

    await minio.putObject(
      bucketName,
      s3Key,
      Stream.value(imageData),
      size: imageData.length,
      metadata: {
        'Content-Type': contentType,
      },
    );

    return s3Key;
  }

  static Future<String> uploadMenuImage(
    Session session,
    String fileName,
    Uint8List imageData,
    String contentType,
  ) async {
    _getClient(session);
    return uploadImage(session, _menuBucket!, fileName, imageData, contentType);
  }

  static Future<String> uploadStoreImage(
    Session session,
    String fileName,
    Uint8List imageData,
    String contentType,
  ) async {
    _getClient(session);
    return uploadImage(
      session,
      _storeBucket!,
      fileName,
      imageData,
      contentType,
    );
  }

  static Future<void> deleteImage(
    Session session,
    String bucketName,
    String s3Key,
  ) async {
    final minio = _getClient(session);

    try {
      await minio.removeObject(bucketName, s3Key);
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  static Future<void> deleteMenuImage(Session session, String s3Key) async {
    _getClient(session);
    return deleteImage(session, _menuBucket!, s3Key);
  }

  static Future<void> deleteStoreImage(Session session, String s3Key) async {
    _getClient(session);
    return deleteImage(session, _storeBucket!, s3Key);
  }

  static String getImageUrl(Session session, String bucketName, String s3Key) {
    _getClient(session);
    return 'http://$_endpoint:$_port/$bucketName/$s3Key';
  }

  static String getMenuImageUrl(Session session, String s3Key) {
    _getClient(session);
    return getImageUrl(session, _menuBucket!, s3Key);
  }

  static String getStoreImageUrl(Session session, String s3Key) {
    _getClient(session);
    return getImageUrl(session, _storeBucket!, s3Key);
  }

  static Future<Uint8List> getImage(
    Session session,
    String bucketName,
    String s3Key,
  ) async {
    final minio = _getClient(session);

    try {
      final stream = await minio.getObject(bucketName, s3Key);
      final bytes = await stream.expand((chunk) => chunk).toList();
      return Uint8List.fromList(bytes);
    } catch (e) {
      throw Exception('Failed to get image: $e');
    }
  }

  static Future<Uint8List> getMenuImage(Session session, String s3Key) async {
    _getClient(session);
    return getImage(session, _menuBucket!, s3Key);
  }

  static Future<Uint8List> getStoreImage(Session session, String s3Key) async {
    _getClient(session);
    return getImage(session, _storeBucket!, s3Key);
  }
}
