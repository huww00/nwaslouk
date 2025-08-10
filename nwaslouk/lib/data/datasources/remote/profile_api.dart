import 'package:dio/dio.dart';

class ProfileApi {
  final Dio _dio;
  ProfileApi(this._dio);

  Future<Response<dynamic>> getProfile() {
    return _dio.get('/profile');
  }
}