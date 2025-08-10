class Trip {
  final String id;
  final String driverName;
  final String departureCity;
  final String destinationCity;
  final DateTime departureTime;
  final int availableSeats;
  final double price;

  const Trip({
    required this.id,
    required this.driverName,
    required this.departureCity,
    required this.destinationCity,
    required this.departureTime,
    required this.availableSeats,
    required this.price,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json['id'] as String,
        driverName: json['driver_name'] as String,
        departureCity: json['departure_city'] as String,
        destinationCity: json['destination_city'] as String,
        departureTime: DateTime.parse(json['departure_time'] as String),
        availableSeats: json['available_seats'] as int,
        price: (json['price'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'driver_name': driverName,
        'departure_city': departureCity,
        'destination_city': destinationCity,
        'departure_time': departureTime.toIso8601String(),
        'available_seats': availableSeats,
        'price': price,
      };
}