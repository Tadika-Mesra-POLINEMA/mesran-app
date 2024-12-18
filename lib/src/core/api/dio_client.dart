import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  final GoRouter _router;

  DioClient(this._secureStorage, this._router, {required String baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cache-Control': 'no-cache',
          },
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        await _addAuthorizationHeader(options);
        handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          final isRefreshed = await _refreshToken();
          if (isRefreshed) {
            final newRequest = await _retryRequest(error.requestOptions);
            return handler.resolve(newRequest);
          } else {
            _router.go('/login');
          }
        }

        handler.next(error);
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<void> _addAuthorizationHeader(RequestOptions options) async {
    if (options.path.contains('/login')) return;
    final token = await _secureStorage.read(key: 'accessToken');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _secureStorage.read(key: 'refreshToken');
      if (refreshToken == null) return false;

      final response = await _dio.put(
        '/api/authentications/refresh',
        data: {'refreshToken': refreshToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['data']['accessToken'];
        await _secureStorage.write(key: 'accessToken', value: newAccessToken);
        return true;
      }
    } catch (e) {
      debugPrint('Error refreshing token: $e');
    }
    return false;
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final newToken = await _secureStorage.read(key: 'accessToken');
    final headers = Map<String, dynamic>.from(requestOptions.headers);
    if (newToken != null) {
      headers['Authorization'] = 'Bearer $newToken';
    }

    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: headers,
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        followRedirects: requestOptions.followRedirects,
        validateStatus: requestOptions.validateStatus,
      ),
    );
  }

  Dio get client => _dio;

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    return await _dio.get(
      endpoint,
      queryParameters: queryParams,
    );
  }

  Future<Response> post(String endpoint,
      {Map<String, dynamic>? data, Options? options}) async {
    return await _dio.post(endpoint, data: data, options: options);
  }
}
