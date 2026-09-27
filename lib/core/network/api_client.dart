import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
        final username = await storage.read(key: 'username');
        final password = await storage.read(key: 'password');
        if (username != null && password != null) {
          final credentials = base64Encode(utf8.encode('$username:$password'));
          options.headers['Authorization'] = 'Basic $credentials';
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
