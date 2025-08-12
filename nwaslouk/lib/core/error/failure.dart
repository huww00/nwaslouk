class Failure {
  final String message;
  final String code;
  final int? statusCode;

  const Failure({
    required this.message,
    this.code = 'unknown',
    this.statusCode,
  });

  @override
  String toString() => 'Failure(code: $code, status: $statusCode, message: $message)';

  static Failure network([String message = 'Network error']) => Failure(message: message, code: 'network');
  static Failure unauthorized([String message = 'Unauthorized']) => Failure(message: message, code: 'unauthorized', statusCode: 401);
  static Failure notFound([String message = 'Not found']) => Failure(message: message, code: 'not_found', statusCode: 404);
  static Failure server([String message = 'Server error']) => Failure(message: message, code: 'server');
  static Failure validation([String message = 'Validation error']) => Failure(message: message, code: 'validation');
  static Failure conflict([String message = 'Conflict']) => Failure(message: message, code: 'conflict', statusCode: 409);
}