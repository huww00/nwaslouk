import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

import 'package:nwaslouk/data/datasources/mock/mock_data.dart';
import 'package:nwaslouk/data/datasources/remote/trip_api.dart';
import 'package:nwaslouk/data/repositories_impl/trip_repository_impl.dart';

class _MockTripApi extends Mock implements TripApi {}

void main() {
  late _MockTripApi api;
  late MockData mockData;
  late TripRepositoryImpl repo;

  setUp(() {
    api = _MockTripApi();
    mockData = MockData();
    repo = TripRepositoryImpl(api: api, mockData: mockData);
  });

  test('searchTrips returns right on API success', () async {
    when(() => api.searchTrips(fromCity: any(named: 'fromCity'), toCity: any(named: 'toCity'), dateIso: any(named: 'dateIso')))
        .thenAnswer((_) async => Response(requestOptions: RequestOptions(path: '/trips'), data: [
              {
                'id': '1',
                'driver_name': 'Driver',
                'departure_city': 'Tunis',
                'destination_city': 'Sousse',
                'departure_time': DateTime(2025, 1, 1).toIso8601String(),
                'available_seats': 3,
                'price': 20,
              }
            ]));

    final res = await repo.searchTrips(fromCity: 'Tunis', toCity: 'Sousse', date: DateTime(2025, 1, 1));
    expect(res.isRight(), true);
  });

  test('searchTrips falls back to mock on unexpected error', () async {
    when(() => api.searchTrips(fromCity: any(named: 'fromCity'), toCity: any(named: 'toCity'), dateIso: any(named: 'dateIso')))
        .thenThrow(Exception('any'));

    final res = await repo.searchTrips(fromCity: 'Tunis', toCity: 'Sousse', date: DateTime(2025, 1, 1));
    expect(res.isRight(), true);
  });
}