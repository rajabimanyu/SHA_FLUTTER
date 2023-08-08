import 'package:sha/core/network/network_error.dart';

class ApiResponse<T, E extends NetworkError> {
  final T? data;
  final E? error;
  final bool success;

  const ApiResponse.completed(this.data)
      : error = null,
        success = true;

  const ApiResponse.error(this.error)
      : data = null,
        success = false;
}
