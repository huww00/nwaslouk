import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/booking_provider.dart';

class BookingPage extends ConsumerWidget {
  static const String routeName = '/booking';
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookingProvider);
    final notifier = ref.read(bookingProvider.notifier);

    final tripId = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Seats')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Trip: ${tripId ?? '-'}'),
            Row(
              children: [
                const Text('Seats'),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: state.seats,
                  onChanged: notifier.updateSeats,
                  items: List.generate(6, (i) => i + 1)
                      .map((e) => DropdownMenuItem<int>(value: e, child: Text('$e')))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (state.error != null) Text(state.error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: state.isLoading || tripId == null
                  ? null
                  : () async {
                      final ok = await notifier.book(tripId);
                      if (context.mounted && ok) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Booked successfully')));
                        Navigator.of(context).pop();
                      }
                    },
              child: state.isLoading ? const CircularProgressIndicator() : const Text('Confirm Booking'),
            )
          ],
        ),
      ),
    );
  }
}