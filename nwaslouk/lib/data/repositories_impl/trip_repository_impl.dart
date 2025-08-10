import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/mock/mock_data.dart';
import '../datasources/remote/trip_api.dart';

class TripRepositoryImpl implements TripRepository {
  final TripApi api;
  final MockData mockData;
  TripRepositoryImpl({required this.api, required this.mockData});

  @override
  Future<Either<Failure, List<Trip>>> searchTrips({
    required String fromCity,
    required String toCity,
    required DateTime date,
  }) async {
    try {
      final res = await api.searchTrips(
        fromCity: fromCity,
        toCity: toCity,
        dateIso: date.toIso8601String(),
      );
      final data = (res.data as List<dynamic>).cast<Map<String, dynamic>>();
      final trips = data.map(Trip.fromJson).toList();
      return Right(trips);
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } catch (_) {
      // Offline dev: return mock
      final filtered = mockData.trips
          .where((t) => t.departureCity == fromCity && t.destinationCity == toCity)
          .toList();
      return Right(filtered);
    }
  }

  @override
  Future<Either<Failure, Trip>> publishTrip({
    required String driverName,
    required String fromCity,
    required String toCity,
    required DateTime departureTime,
    required int totalSeats,
    required double price,
  }) async {
    try {
      final res = await api.publishTrip({
        'driver_name': driverName,
        'departure_city': fromCity,
        'destination_city': toCity,
        'departure_time': departureTime.toIso8601String(),
        'total_seats': totalSeats,
        'price': price,
      });
      final trip = Trip.fromJson(res.data as Map<String, dynamic>);
      return Right(trip);
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } catch (_) {
      // Mock created trip
      return Right(Trip(
        id: 't_mock',
        driverName: driverName,
        departureCity: fromCity,
        destinationCity: toCity,
        departureTime: departureTime,
        availableSeats: totalSeats,
        price: price,
      ));
    }
  }

  Failure _mapDioException(DioException e) {
    final status = e.response?.statusCode;
    if (status == 401) return Failure.unauthorized();
    if (status == 404) return Failure.notFound();
    return Failure.server(e.message ?? 'Server error');
  }
}