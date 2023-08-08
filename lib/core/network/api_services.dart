import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sha/core/network/network_constants.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio
      ..options.connectTimeout =
          const Duration(milliseconds: Endpoints.connectionTimeout)
      ..options.receiveTimeout =
          const Duration(milliseconds: Endpoints.receiveTimeout)
      ..options.responseType = ResponseType.json
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
            headers: options?.headers, responseType: options?.responseType),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: options?.headers),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: options?.headers),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Patch:-----------------------------------------------------------------------
  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
  }) async {
    try {
      final Response response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: options?.headers),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: options?.headers),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

class ApiOptions {
  Map<String, dynamic>? headers;
  ResponseType? responseType;

  ApiOptions({
    this.headers,
    this.responseType,
  });
}
