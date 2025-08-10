import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/mock/mock_data.dart';
import '../datasources/remote/booking_api.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingApi api;
  final MockData mockData;
  BookingRepositoryImpl({required this.api, required this.mockData});

  @override
  Future<Either<Failure, Booking>> bookSeat({required String tripId, required int seats}) async {
    try {
      final res = await api.bookSeat({'trip_id': tripId, 'seats': seats});
      final booking = Booking.fromJson(res.data as Map<String, dynamic>);
      return Right(booking);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 401) return Left(Failure.unauthorized());
      if (status == 404) return Left(Failure.notFound());
      return Left(Failure.server(e.message ?? 'Server error'));
    } catch (_) {
      return Right(mockData.book(tripId, seats));
    }
  }
}