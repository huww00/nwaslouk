class Booking {
  final String id;
  final String tripId;
  final String userId;
  final int seats;
  final String status; // e.g., pending, confirmed

  const Booking({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.seats,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'] as String,
        tripId: json['trip_id'] as String,
        userId: json['user_id'] as String,
        seats: json['seats'] as int,
        status: json['status'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'trip_id': tripId,
        'user_id': userId,
        'seats': seats,
        'status': status,
      };
}