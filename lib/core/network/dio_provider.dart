import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/secure_storage_service.dart';
import 'dio_client.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logger_interceptor.dart';

final loggerInterceptorProvider = Provider<LoggerInterceptor>((ref) {
  return LoggerInterceptor();
});

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  return AuthInterceptor(
    ref.read(secureStorageProvider),
  );
});

final dioProvider = Provider<Dio>((ref) {
  return DioClient(
    authInterceptor: ref.read(authInterceptorProvider),
    loggerInterceptor: ref.read(loggerInterceptorProvider),
  ).dio;
});