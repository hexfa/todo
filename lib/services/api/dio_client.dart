import 'package:dio/dio.dart';

Dio createDio(String token) {
  final dio = Dio();

  dio.options.headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  return dio;
}
