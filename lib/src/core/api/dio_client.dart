import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio _dio;

  DioClient({required String baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        await _addAuthorizationHeader(options);
        handler.next(options);
      },
      onError: (DioException error, handler) async {
        final response = error.response;

        if (response != null && response.statusCode == 401) {
          // AccessToken expired, attempt to refresh
          final isRefreshed = await _refreshToken();
          if (isRefreshed) {
            // Retry the failed request
            final newRequest = await _retryRequest(error.requestOptions);
            return handler.resolve(newRequest);
          }
        }

        handler.next(error); // Pass the error if refreshing fails
      },
    ));
  }

  /// Add Authorization header to requests
  Future<void> _addAuthorizationHeader(RequestOptions options) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }

  /// Refresh access token
  Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');

      if (refreshToken == null) {
        // No refresh token found, user needs to log in again
        return false;
      }

      // Send refresh token to server
      final response = await _dio.post(
        '/api/authentications/refresh',
        data: {'refreshToken': refreshToken},
      );

      // Save the new accessToken
      final newAccessToken = response.data['accessToken'];
      prefs.setString('accessToken', newAccessToken);

      return true;
    } catch (e) {
      // Handle refresh failure
      return false;
    }
  }

  /// Retry the failed request with the new accessToken
  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final prefs = await SharedPreferences.getInstance();
    final newToken = prefs.getString('accessToken');
    final headers = Map<String, dynamic>.from(requestOptions.headers);

    // Update Authorization header
    if (newToken != null) {
      headers['Authorization'] = 'Bearer $newToken';
    }

    // Retry the original request
    final options = Options(
      method: requestOptions.method,
      headers: headers,
    );

    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Dio get client => _dio;

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    return await _dio.get(endpoint, queryParameters: queryParams);
  }

  Future<Response> post(String endpoint,
      {Map<String, dynamic>? data, Options? options}) async {
    return await _dio.post(endpoint, data: data, options: options);
  }
}
