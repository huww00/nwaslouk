import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/map_view.dart';
import '../widgets/destination_search_bar.dart';
import '../widgets/quick_actions_panel.dart';
import '../widgets/recent_locations_section.dart';
import '../widgets/louage_type_selector.dart';
import '../widgets/bottom_navigation_panel.dart';
import '../../profile/pages/profile_page.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _showLocationsList = false;
  bool _showLouageTypes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map View (Background)
          const MapView(),
          
          // Top UI Elements
          SafeArea(
            child: Column(
              children: [
                // Header with profile and menu
                _buildHeader(),
                
                const SizedBox(height: 16),
                
                // Destination Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DestinationSearchBar(
                    onTap: () => setState(() => _showLocationsList = true),
                  ),
                ),
                
                const Spacer(),
                
                // Bottom Panel with actions
                if (!_showLocationsList && !_showLouageTypes)
                  const QuickActionsPanel(),
              ],
            ),
          ),
          
          // Sliding Panels
          if (_showLocationsList)
            RecentLocationsSection(
              onClose: () => setState(() => _showLocationsList = false),
              onLocationSelected: (location) {
                setState(() => _showLocationsList = false);
                // Handle location selection
              },
            ),
          
          if (_showLouageTypes)
            LouageTypeSelector(
              onClose: () => setState(() => _showLouageTypes = false),
              onTypeSelected: (type) {
                setState(() => _showLouageTypes = false);
                // Handle louage type selection
              },
            ),
          
          // Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationPanel(
              onLouageTypeTap: () => setState(() => _showLouageTypes = true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Menu Button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFFE53E3E)),
              onPressed: () {
                // Show side menu
              },
            ),
          ),
          
          const Spacer(),
          
          // App Title
          const Text(
            'نوصلوك',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE53E3E),
            ),
          ),
          
          const Spacer(),
          
          // Profile Button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.person, color: Color(0xFFE53E3E)),
              onPressed: () => Navigator.of(context).pushNamed(ProfilePage.routeName),
            ),
          ),
        ],
      ),
    );
  }
}