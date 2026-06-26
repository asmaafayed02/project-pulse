import 'package:dio/dio.dart';
import 'package:project_pulse/core/errors/failures.dart';
import 'package:project_pulse/core/network/network_error_handler.dart';

/// Converts ANY caught object into a user-safe message.
/// This is the only place the UI should ever read an error message from.
class ErrorMessageMapper {
  ErrorMessageMapper._();

  static String map(Object error) {
    if (error is Failure) return error.message;
    if (error is DioException) return NetworkErrorHandler.fromDio(error).message;
    return 'Something went wrong. Please try again.';
  }
}