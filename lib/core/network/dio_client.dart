import 'package:dio/dio.dart';
import 'package:project_pulse/core/api/api_constants.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/logger_interceptor.dart';

class DioClient {
  DioClient({
    required AuthInterceptor authInterceptor,
    required LoggerInterceptor loggerInterceptor,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.dummyJsonBaseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            headers: {
              Headers.acceptHeader: 'application/json',
              Headers.contentTypeHeader: 'application/json',
            },
          ),
        ) {
    dio.interceptors.addAll([
      authInterceptor,
      loggerInterceptor,
    ]);
  }

  final Dio dio;
}