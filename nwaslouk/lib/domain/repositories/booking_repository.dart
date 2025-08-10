import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/booking.dart';

abstract class BookingRepository {
  Future<Either<Failure, Booking>> bookSeat({
    required String tripId,
    required int seats,
  });
}