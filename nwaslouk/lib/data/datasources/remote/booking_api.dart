import 'package:dio/dio.dart';

class BookingApi {
  final Dio _dio;
  BookingApi(this._dio);

  Future<Response<dynamic>> bookSeat(Map<String, dynamic> body) {
    return _dio.post('/bookings', data: body);
  }
}