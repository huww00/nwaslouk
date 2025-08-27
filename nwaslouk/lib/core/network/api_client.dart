import 'package:dio/dio.dart';
import '../env/environment.dart';
import '../logging/app_logger.dart';

class ApiClient {
  static Dio createDio({
    required String baseUrl,
    required Future<String?> Function() tokenProvider,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          final token = await tokenProvider();
          if (token != null && token.isNotEmpty) {
            options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
          }
        } catch (_) {
          // Swallow token read errors to avoid blocking requests
        }
        if (Environment.current.enableNetworkLogs) {
          AppLogger.d('[REQ] ${options.method} ${options.uri}');
          AppLogger.d(options.data);
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        if (Environment.current.enableNetworkLogs) {
          AppLogger.d('[RES] ${response.statusCode} ${response.requestOptions.uri}');
        }
        handler.next(response);
      },
      onError: (e, handler) {
        AppLogger.e('[ERR] ${e.requestOptions.uri}', e, e.stackTrace);
        handler.next(e);
      },
    ));

    return dio;
  }
}