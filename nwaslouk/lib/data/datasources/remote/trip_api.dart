import 'package:dio/dio.dart';

class TripApi {
  final Dio _dio;
  TripApi(this._dio);

  Future<Response<dynamic>> searchTrips({
    required String fromCity,
    required String toCity,
    required String dateIso,
  }) {
    return _dio.get('/trips', queryParameters: {
      'from': fromCity,
      'to': toCity,
      'date': dateIso,
    });
  }

  Future<Response<dynamic>> publishTrip(Map<String, dynamic> body) {
    return _dio.post('/trips', data: body);
  }
}