import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/network/api_client.dart';

import 'dio_client.dart';
import 'interceptors/logger_interceptor.dart';

final loggerInterceptorProvider = Provider<LoggerInterceptor>((ref) {
  return LoggerInterceptor();
});

final dioProvider = Provider<Dio>((ref) {
  return DioClient(
    loggerInterceptor: ref.read(loggerInterceptorProvider),
  ).dio;
});
final apiClientProvider =
    Provider<ApiClient>(
  (ref) => ApiClient(
    ref.read(dioProvider),
  ),
);