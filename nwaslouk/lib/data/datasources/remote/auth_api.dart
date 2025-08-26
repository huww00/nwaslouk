import 'package:dio/dio.dart';

class AuthApi {
  final Dio _dio;
  AuthApi(this._dio);

  Future<Response<dynamic>> signIn(Map<String, dynamic> body) {
    return _dio.post('/auth/sign-in', data: body);
  }

  Future<Response<dynamic>> signUp(Map<String, dynamic> body) {
    return _dio.post('/auth/sign-up', data: body);
  }

  Future<Response<dynamic>> signInWithGoogle(Map<String, dynamic> body) {
    return _dio.post('/auth/google', data: body);
  }

  Future<Response<dynamic>> logout() {
    return _dio.post('/auth/logout');
  }

  Future<Response<dynamic>> checkEmail(String email) {
    return _dio.get('/auth/check-email', queryParameters: { 'email': email });
  }

  Future<Response<dynamic>> checkPhone(String phone) {
    return _dio.get('/auth/check-phone', queryParameters: { 'phone': phone });
  }
}