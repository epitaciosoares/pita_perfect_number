part of '../dependencies.dart';

Dio createDio() {
  final dio = Dio();
  dio.options.baseUrl = 'http://localhost:8080';
  return dio;
}
