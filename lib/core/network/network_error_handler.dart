import 'dart:io';
import 'package:dio/dio.dart';
import 'package:project_pulse/core/errors/failures.dart';

/// Converts any [DioException] into a typed [Failure].
class NetworkErrorHandler {
  NetworkErrorHandler._();

  static Failure fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        // errno 103 = connection aborted, 101 = network unreachable, etc.
        return const NetworkFailure(
          'No internet connection. Please check your network and try again.',
        );

      case DioExceptionType.badResponse:
        final code = e.response?.statusCode ?? 0;
        return switch (code) {
          401 => const UnauthorizedFailure('Session expired. Please log in again.'),
          403 => const ServerFailure('You don\'t have permission to do that.'),
          404 => const ServerFailure('The requested resource was not found.'),
          408 => const NetworkFailure('Request timed out. Please try again.'),
          429 => const ServerFailure('Too many requests. Please slow down.'),
          >= 500 => const ServerFailure('Server error. Please try again later.'),
          _ => ServerFailure('Unexpected error (HTTP $code).'),
        };

      case DioExceptionType.cancel:
        return const ServerFailure('Request was cancelled.');

      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return const NetworkFailure(
            'No internet connection. Please check your network and try again.',
          );
        }
        return ServerFailure(e.message ?? 'An unexpected error occurred.');

      default:
        return ServerFailure(e.message ?? 'An unexpected error occurred.');
    }
  }
}
