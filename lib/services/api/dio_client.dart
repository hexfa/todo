import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

Dio createDio(String token) {
  final dio = Dio();

  dio.options.headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add X-Request-Id header
        options.headers['X-Request-Id'] = const Uuid().v4();
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        // Handle errors globally if needed
        return handler.next(e);
      },
    ),
  );

  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
  ));

  return dio;
}
