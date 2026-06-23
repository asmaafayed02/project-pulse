import 'package:dio/dio.dart';
import 'package:project_pulse/core/services/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storage);

  final SecureStorageService _storage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}