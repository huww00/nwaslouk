import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../domain/usecases/booking/book_seat_usecase.dart';

class BookingState {
  final int seats;
  final bool isLoading;
  final String? error;

  const BookingState({this.seats = 1, this.isLoading = false, this.error});

  BookingState copyWith({int? seats, bool? isLoading, String? error}) =>
      BookingState(seats: seats ?? this.seats, isLoading: isLoading ?? this.isLoading, error: error);
}

class BookingNotifier extends StateNotifier<BookingState> {
  final BookSeatUseCase _useCase = sl<BookSeatUseCase>();
  BookingNotifier() : super(const BookingState());

  void updateSeats(int? v) => state = state.copyWith(seats: v ?? 1, error: null);

  Future<bool> book(String tripId) async {
    state = state.copyWith(isLoading: true, error: null);
    final res = await _useCase(BookSeatParams(tripId: tripId, seats: state.seats));
    return res.fold((l) {
      state = state.copyWith(isLoading: false, error: l.message);
      return false;
    }, (r) {
      state = state.copyWith(isLoading: false);
      return true;
    });
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>((ref) => BookingNotifier());