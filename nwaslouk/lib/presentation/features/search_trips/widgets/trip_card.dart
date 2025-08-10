import 'package:flutter/material.dart';
import '../../../../domain/entities/trip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${trip.departureCity} → ${trip.destinationCity}'),
        subtitle: Text('Driver: ${trip.driverName}\n${trip.departureTime} | Seats: ${trip.availableSeats} | ${trip.price} TND'),
      ),
    );
  }
}