import 'package:dio/dio.dart';
import 'dart:async';

class ApiClient {
  final Dio dio;

  ApiClient(String baseUrl) : dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Response> _retryRequest(Future<Response> Function() request,
      {int retries = 3, Duration delay = const Duration(seconds: 2)}) async {
    DioException? lastError;

    for (int attempt = 0; attempt < retries; attempt++) {
      try {
        return await request();
      } on DioException catch (e) {
        lastError = e;
        if (attempt < retries - 1) {
          await Future.delayed(delay);
        }
      }
    }
    throw lastError ?? Exception('Request failed after $retries retries');
  }

  Future<Response> get(String path) =>
      _retryRequest(() => dio.get(path));

  Future<Response> post(String path, dynamic data) =>
      _retryRequest(() => dio.post(path, data: data));

  Future<Response> put(String path, dynamic data) =>
      _retryRequest(() => dio.put(path, data: data));

  Future<Response> delete(String path) =>
      _retryRequest(() => dio.delete(path));
}
