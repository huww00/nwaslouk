import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/trip.dart';
import '../../repositories/trip_repository.dart';

class SearchTripsParams {
  final String fromCity;
  final String toCity;
  final DateTime date;

  const SearchTripsParams({
    required this.fromCity,
    required this.toCity,
    required this.date,
  });
}

class SearchTripsUseCase {
  final TripRepository repository;
  const SearchTripsUseCase(this.repository);

  Future<Either<Failure, List<Trip>>> call(SearchTripsParams params) {
    return repository.searchTrips(
      fromCity: params.fromCity,
      toCity: params.toCity,
      date: params.date,
    );
  }
}