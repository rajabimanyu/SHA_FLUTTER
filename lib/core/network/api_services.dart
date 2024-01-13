import 'dart:collection';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sha/core/network/network_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Map<String, dynamic>? queryParameters
  }) async {
    try {
      log("get call");
      final user = FirebaseAuth.instance.currentUser;
      final IdTokenResult? idTokenResult = await user?.getIdTokenResult();
      String? idToken = idTokenResult?.token ?? '';

      log('get call : $idToken');
      ApiOptions apiOptions = ApiOptions();
      apiOptions.headers = HashMap<String, dynamic>();
      if(idToken != null) {
        log("get call sessionKey");
        apiOptions.headers?['Authorization'] = 'Bearer $idToken';
      }
      log('api service : ${apiOptions.headers}');
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
            headers: {"Authorization":"Bearer $idToken"}, responseType: apiOptions.responseType),
      );
      log('responjse : ${response.data}');
      return response.data;
    } catch (e, stackTrace) {
      log("dio err : ${stackTrace.toString()}");
      log("dio err : ${e.toString()}");
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
      String? sessionKey = await getSession();
      if(sessionKey != null) {
        options?.headers?['Authorization'] = 'Bearer $sessionKey';
      }
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
      String? sessionKey = await getSession();
      if(sessionKey != null) {
        options?.headers?['Authorization'] = 'Bearer $sessionKey';
      }
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
      String? sessionKey = await getSession();
      if(sessionKey != null) {
        options?.headers?['Authorization'] = 'Bearer $sessionKey';
      }
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

  Future<String?> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString('session_id');
    log("session = $sessionId");
    return sessionId;
  }
}

class ApiOptions {
  Map<String, dynamic>? headers;
  ResponseType? responseType;

  ApiOptions({
    this.headers,
    this.responseType = ResponseType.json,
  });
}
