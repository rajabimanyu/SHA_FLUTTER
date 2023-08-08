import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  factory ApiException.fromError(DioException dioError) {
    String message;
    final statusCode = dioError.response?.statusCode;
    if (statusCode != null) {
      message = _getErrorMessage(statusCode, dioError.message);
    }
    switch (dioError.type) {
      case DioException.requestCancelled:
        message = 'Request to API server was cancelled';
        break;
      case DioException.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        break;
      case DioException.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      default:
        message = 'Something went wrong';
        break;
    }
    return ApiException(message);
  }

  static String _getErrorMessage(int? statusCode, String? error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return error ?? 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}

class ApiError extends DioException {
  ApiError({required super.requestOptions});
}
