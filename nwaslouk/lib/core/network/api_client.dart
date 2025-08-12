import 'package:dio/dio.dart';
import '../env/environment.dart';
import '../logging/app_logger.dart';
import '../../data/datasources/local/local_store.dart';

class ApiClient {
  static Dio createDio({required String baseUrl}) {
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
        // Attach auth token if available
        try {
          final token = await LocalStore().getAuthToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (_) {}
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