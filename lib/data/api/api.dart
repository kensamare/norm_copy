// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

/// Stands for handling API calls.
class Api {
  Api({
    required this.baseUrl,
    this.retries,
  }) {
    _dio = Dio(
      BaseOptions(baseUrl: baseUrl),
    );

    _addInterceptors();
  }

  /// Api requests url.
  final String baseUrl;

  /// Retries count after request error.
  final int? retries;

  /// Dio instance.
  late Dio _dio;

  /// Authorization token.
  String? _authToken;

  /// Authorization token. To set up token use `setToken()` method.
  String? get authToken => _authToken;

  /// Adds interceptors to request.
  void _addInterceptors() {
    final InterceptorsWrapper logInterceptor = InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        log('REQUEST [${options.method}] => PATH: ${options.path}');
        log('PARAMS [${options.data ?? options.queryParameters}]');

        handler.next(options);
      },
    );

    final QueuedInterceptorsWrapper authorizationInterceptor = QueuedInterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // Provide auth token with request.
        options.headers = {
          ...options.headers,
          'Access-Token': _authToken,
        };

        // Log access token header.
        log('HEADERS [${options.headers}]');

        handler.next(options);
      },
      onError: (DioError err, ErrorInterceptorHandler handler) {
        handler.next(err);
      },
    );

    _dio.interceptors.addAll(
      [
        // Logs all requests.
        logInterceptor,

        // Authorization interceptor. Handles unathorized exception.
        authorizationInterceptor,

        // If user selected to retry requests.
        if (retries != null)
          RetryInterceptor(
            dio: _dio,
            retries: retries!,
            logPrint: (message) => log(message),
            retryDelays: List.generate(
              retries!,
              (index) => Duration(seconds: index * index + 2), // Quadratic dependence delay.
            ),
          ),
      ],
    );
  }

  /// Performs GET request.
  ///
  ///
  /// If the `method` starts with 'http(s)', the `baseUrl` will be ignored, otherwise,
  /// it will be combined and then resolved with the baseUrl.
  Future<Response?> get({required String method, Map<String, dynamic>? params}) async {
    return await _dio.get(method, queryParameters: params);
  }

  /// Performs POST request.
  ///
  ///
  /// If the `method` starts with 'http(s)', the `baseUrl` will be ignored, otherwise,
  /// it will be combined and then resolved with the baseUrl.
  Future<Response?> post({required String method, dynamic body}) async {
    return await _dio.post(method, data: body);
  }

  /// Performs PUT request.
  ///
  ///
  /// If the `method` starts with 'http(s)', the `baseUrl` will be ignored, otherwise,
  /// it will be combined and then resolved with the baseUrl.
  Future<Response?> put({required String method, dynamic body}) async {
    return await _dio.put(method, data: body);
  }

  /// Performs DELETE request.
  ///
  ///
  /// If the `method` starts with 'http(s)', the `baseUrl` will be ignored, otherwise,
  /// it will be combined and then resolved with the baseUrl.
  Future<Response?> delete({required String method}) async {
    return await _dio.delete(method);
  }

  /// Sets authorization token.
  ///
  ///
  /// Mustn't be empty or null. To clear token use `clearToken()` method.
  void setToken(String token) {
    _authToken = token;
  }

  /// Clears token.
  void clearToken() {
    _authToken = null;
  }
}
