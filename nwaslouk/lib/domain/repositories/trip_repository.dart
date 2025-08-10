import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/trip.dart';

abstract class TripRepository {
  Future<Either<Failure, List<Trip>>> searchTrips({
    required String fromCity,
    required String toCity,
    required DateTime date,
  });

  Future<Either<Failure, Trip>> publishTrip({
    required String driverName,
    required String fromCity,
    required String toCity,
    required DateTime departureTime,
    required int totalSeats,
    required double price,
  });
}