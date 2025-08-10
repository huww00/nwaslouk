import 'package:dio/dio.dart';

class AuthApi {
  final Dio _dio;
  AuthApi(this._dio);

  Future<Response<dynamic>> signIn(Map<String, dynamic> body) {
    return _dio.post('/auth/sign-in', data: body);
  }
}