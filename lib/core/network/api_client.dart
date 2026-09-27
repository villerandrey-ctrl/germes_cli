import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final storage = const FlutterSecureStorage();
        final cookie = await storage.read(key: 'session_cookie');
        if (cookie != null) {
          options.headers['Cookie'] = cookie;
        }
        return handler.next(options);
      },
    ),
  );

  return dio;
});

final baseUrlProvider = StateProvider<String>((ref) {
  return '';
});
