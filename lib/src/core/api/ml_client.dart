import 'package:dio/dio.dart';

class ML {
  final Dio _dio;

  ML({required String baseUrl})
      : _dio = Dio(BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
            headers: {'Content-Type': 'form-data'}));

  Dio get client => _dio;
}
