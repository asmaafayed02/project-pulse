import 'package:dio/dio.dart';

class LoggerInterceptor extends LogInterceptor {
  LoggerInterceptor()
      : super(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
          error: true,
        );
}