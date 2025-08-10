import 'package:flutter/material.dart';

class BookingsHistoryPage extends StatelessWidget {
  static const String routeName = '/bookings';
  const BookingsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: const Center(child: Text('No bookings yet')),
    );
  }
}