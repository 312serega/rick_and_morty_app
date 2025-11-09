import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioSettings {
  DioSettings() {
    setup();
  }
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api/',
      contentType: 'application/json',
      headers: {'Accept': 'application/json'},
      connectTimeout: const Duration(milliseconds: 20000),
      receiveTimeout: const Duration(milliseconds: 20000),
    ),
  );

  void setup() async {
    final interceptor = dio.interceptors;

    interceptor.clear();

    final logInterceptor = LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    );

    final headerInterceptor = QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onError: (DioException error, handler) {
        handler.next(error);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
    );
    interceptor.addAll([if (kDebugMode) logInterceptor, headerInterceptor]);
  }
}
