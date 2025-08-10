import 'package:logger/logger.dart';

class AppLogger {
  static final Logger instance = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  static void d(dynamic message) => instance.d(message);
  static void i(dynamic message) => instance.i(message);
  static void w(dynamic message) => instance.w(message);
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) => instance.e(message, error: error, stackTrace: stackTrace);
}