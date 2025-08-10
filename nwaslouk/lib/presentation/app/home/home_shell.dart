import 'package:flutter/material.dart';
import '../../features/search_trips/pages/search_trips_page.dart';
import '../../features/booking/pages/bookings_history_page.dart';
import '../../features/profile/pages/profile_page.dart';

class HomeShell extends StatefulWidget {
  static const String routeName = '/home';
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final List<Widget> _pages = const [
    SearchTripsPage(),
    BookingsHistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.confirmation_number_outlined), label: 'Bookings'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}