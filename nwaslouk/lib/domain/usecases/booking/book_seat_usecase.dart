import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/booking.dart';
import '../../repositories/booking_repository.dart';

class BookSeatParams {
  final String tripId;
  final int seats;

  const BookSeatParams({
    required this.tripId,
    required this.seats,
  });
}

class BookSeatUseCase {
  final BookingRepository repository;
  const BookSeatUseCase(this.repository);

  Future<Either<Failure, Booking>> call(BookSeatParams params) {
    return repository.bookSeat(tripId: params.tripId, seats: params.seats);
  }
}