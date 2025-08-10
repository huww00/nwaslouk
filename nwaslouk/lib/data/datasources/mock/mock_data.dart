import '../../../domain/entities/trip.dart';
import '../../../domain/entities/booking.dart';
import '../../../domain/entities/user_profile.dart';

class MockData {
  final List<Trip> trips = [
    Trip(
      id: 't1',
      driverName: 'Hatem',
      departureCity: 'Tunis',
      destinationCity: 'Sousse',
      departureTime: DateTime.now().add(const Duration(hours: 3)),
      availableSeats: 3,
      price: 18,
    ),
    Trip(
      id: 't2',
      driverName: 'Mouna',
      departureCity: 'Sfax',
      destinationCity: 'Gabes',
      departureTime: DateTime.now().add(const Duration(hours: 5)),
      availableSeats: 2,
      price: 22,
    ),
  ];

  final UserProfile profile = const UserProfile(
    id: 'u1',
    name: 'Ali Ben Salah',
    phone: '+21612345678',
    rating: 4.6,
    isDriver: true,
  );

  Booking book(String tripId, int seats) {
    return Booking(id: 'b1', tripId: tripId, userId: 'u1', seats: seats, status: 'confirmed');
  }
}