import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/trip.dart';
import '../../../../domain/usecases/trip/search_trips_usecase.dart';
import '../../../../core/di/service_locator.dart';

class SearchTripsState {
  final String fromCity;
  final String toCity;
  final DateTime? date;
  final bool isLoading;
  final String? error;
  final List<Trip> trips;

  const SearchTripsState({
    this.fromCity = '',
    this.toCity = '',
    this.date,
    this.isLoading = false,
    this.error,
    this.trips = const [],
  });

  SearchTripsState copyWith({
    String? fromCity,
    String? toCity,
    DateTime? date,
    bool? isLoading,
    String? error,
    List<Trip>? trips,
  }) =>
      SearchTripsState(
        fromCity: fromCity ?? this.fromCity,
        toCity: toCity ?? this.toCity,
        date: date ?? this.date,
        isLoading: isLoading ?? this.isLoading,
        error: error,
        trips: trips ?? this.trips,
      );
}

class SearchTripsNotifier extends StateNotifier<SearchTripsState> {
  final SearchTripsUseCase _useCase = sl<SearchTripsUseCase>();
  SearchTripsNotifier() : super(const SearchTripsState());

  void updateFromCity(String v) => state = state.copyWith(fromCity: v, error: null);
  void updateToCity(String v) => state = state.copyWith(toCity: v, error: null);
  void updateDate(DateTime v) => state = state.copyWith(date: v, error: null);

  Future<void> search() async {
    if (state.date == null) return;
    state = state.copyWith(isLoading: true, error: null);
    final result = await _useCase(SearchTripsParams(fromCity: state.fromCity, toCity: state.toCity, date: state.date!));
    result.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.message, trips: []),
      (r) => state = state.copyWith(isLoading: false, trips: r),
    );
  }
}

final searchTripsProvider = StateNotifierProvider<SearchTripsNotifier, SearchTripsState>((ref) => SearchTripsNotifier());