import 'package:dio/dio.dart';

Dio createDio(String token) {
  final dio = Dio();

  dio.options.headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
  ));

  return dio;
}
