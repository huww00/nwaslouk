import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/search_trips_provider.dart';
import '../../booking/pages/booking_page.dart';

class SearchTripsPage extends ConsumerWidget {
  static const String routeName = '/search';
  const SearchTripsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchTripsProvider);
    final notifier = ref.read(searchTripsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Search Trips')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'From city'),
                  onChanged: notifier.updateFromCity,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'To city'),
                  onChanged: notifier.updateToCity,
                ),
              ),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: state.date != null ? state.date!.toLocal().toString().split(' ').first : 'Pick a date',
                  ),
                  onTap: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      firstDate: now,
                      lastDate: now.add(const Duration(days: 120)),
                      initialDate: now,
                    );
                    if (picked != null) notifier.updateDate(picked);
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: state.isLoading || state.date == null
                    ? null
                    : () => notifier.search(),
                child: state.isLoading ? const CircularProgressIndicator() : const Text('Search'),
              )
            ]),
            const SizedBox(height: 12),
            if (state.error != null) Text(state.error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: state.trips.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final trip = state.trips[index];
                  return ListTile(
                    title: Text('${trip.departureCity} → ${trip.destinationCity}')
                        ,
                    subtitle: Text('Driver: ${trip.driverName} | ${trip.departureTime} | Seats: ${trip.availableSeats} | ${trip.price} TND'),
                    onTap: () => Navigator.of(context).pushNamed(BookingPage.routeName, arguments: trip.id),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}