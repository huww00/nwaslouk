import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:nwaslouk/domain/repositories/trip_repository.dart';
import 'package:nwaslouk/domain/usecases/trip/search_trips_usecase.dart';
import 'package:nwaslouk/domain/entities/trip.dart';
import 'package:nwaslouk/core/error/failure.dart';

class _MockTripRepository extends Mock implements TripRepository {}

void main() {
  late _MockTripRepository repo;
  late SearchTripsUseCase usecase;

  setUp(() {
    repo = _MockTripRepository();
    usecase = SearchTripsUseCase(repo);
  });

  test('returns list of trips on success', () async {
    final params = SearchTripsParams(fromCity: 'Tunis', toCity: 'Sousse', date: DateTime(2025, 1, 1));
    when(() => repo.searchTrips(fromCity: any(named: 'fromCity'), toCity: any(named: 'toCity'), date: any(named: 'date')))
        .thenAnswer((_) async => Right([Trip(
              id: '1',
              driverName: 'A',
              departureCity: 'Tunis',
              destinationCity: 'Sousse',
              departureTime: DateTime(2025, 1, 1, 8),
              availableSeats: 3,
              price: 20,
            )]));

    final result = await usecase(params);

    expect(result.isRight(), true);
    result.fold((_) => fail('Expected Right'), (trips) => expect(trips, isNotEmpty));
  });

  test('returns failure on error', () async {
    final params = SearchTripsParams(fromCity: 'Tunis', toCity: 'Sousse', date: DateTime(2025, 1, 1));
    when(() => repo.searchTrips(fromCity: any(named: 'fromCity'), toCity: any(named: 'toCity'), date: any(named: 'date')))
        .thenAnswer((_) async => Left(Failure.server()));

    final result = await usecase(params);

    expect(result.isLeft(), true);
  });
}