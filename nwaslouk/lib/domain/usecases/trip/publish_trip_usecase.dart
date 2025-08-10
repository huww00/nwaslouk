import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/trip.dart';
import '../../repositories/trip_repository.dart';

class PublishTripParams {
  final String driverName;
  final String fromCity;
  final String toCity;
  final DateTime departureTime;
  final int totalSeats;
  final double price;

  const PublishTripParams({
    required this.driverName,
    required this.fromCity,
    required this.toCity,
    required this.departureTime,
    required this.totalSeats,
    required this.price,
  });
}

class PublishTripUseCase {
  final TripRepository repository;
  const PublishTripUseCase(this.repository);

  Future<Either<Failure, Trip>> call(PublishTripParams params) {
    return repository.publishTrip(
      driverName: params.driverName,
      fromCity: params.fromCity,
      toCity: params.toCity,
      departureTime: params.departureTime,
      totalSeats: params.totalSeats,
      price: params.price,
    );
  }
}