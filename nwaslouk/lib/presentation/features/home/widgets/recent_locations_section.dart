import 'package:flutter/material.dart';

class RecentLocationsSection extends StatelessWidget {
  final VoidCallback onClose;
  final Function(String) onLocationSelected;

  const RecentLocationsSection({
    super.key,
    required this.onClose,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Search Bar
              _buildSearchBar(),
              
              // Locations List
              Expanded(
                child: _buildLocationsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: onClose,
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Choose Destination',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Color(0xFF718096),
            size: 20,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a place...',
                hintStyle: TextStyle(
                  color: Color(0xFF718096),
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Current Location
        _buildLocationItem(
          icon: Icons.my_location,
          iconColor: const Color(0xFF4285F4),
          title: 'Current Location',
          subtitle: 'Use GPS to find your location',
          onTap: () => onLocationSelected('current'),
        ),
        
        const SizedBox(height: 8),
        
        // Saved Places Section
        _buildSectionHeader('Saved Places'),
        
        _buildLocationItem(
          icon: Icons.home,
          iconColor: const Color(0xFFE53E3E),
          title: 'Home',
          subtitle: 'Add home address',
          onTap: () => onLocationSelected('home'),
          trailing: Icons.add,
        ),
        
        _buildLocationItem(
          icon: Icons.work,
          iconColor: const Color(0xFFE53E3E),
          title: 'Work',
          subtitle: 'Add work address',
          onTap: () => onLocationSelected('work'),
          trailing: Icons.add,
        ),
        
        const SizedBox(height: 16),
        
        // Recent Searches Section
        _buildSectionHeader('Recent Searches'),
        
        _buildLocationItem(
          icon: Icons.history,
          iconColor: const Color(0xFF718096),
          title: 'Tunis Centre Ville',
          subtitle: 'Avenue Habib Bourguiba, Tunis',
          onTap: () => onLocationSelected('tunis_centre'),
        ),
        
        _buildLocationItem(
          icon: Icons.history,
          iconColor: const Color(0xFF718096),
          title: 'Sousse Medina',
          subtitle: 'Medina, Sousse',
          onTap: () => onLocationSelected('sousse_medina'),
        ),
        
        _buildLocationItem(
          icon: Icons.history,
          iconColor: const Color(0xFF718096),
          title: 'Sfax University',
          subtitle: 'University of Sfax, Sfax',
          onTap: () => onLocationSelected('sfax_university'),
        ),
        
        const SizedBox(height: 16),
        
        // Popular Destinations Section
        _buildSectionHeader('Popular Destinations'),
        
        _buildLocationItem(
          icon: Icons.location_city,
          iconColor: const Color(0xFFE53E3E),
          title: 'Tunis Airport',
          subtitle: 'Tunis-Carthage International Airport',
          onTap: () => onLocationSelected('tunis_airport'),
        ),
        
        _buildLocationItem(
          icon: Icons.location_city,
          iconColor: const Color(0xFFE53E3E),
          title: 'Sidi Bou Said',
          subtitle: 'Tourist destination',
          onTap: () => onLocationSelected('sidi_bou_said'),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF4A5568),
        ),
      ),
    );
  }

  Widget _buildLocationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    IconData? trailing,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF2D3748),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF718096),
        ),
      ),
      trailing: trailing != null
          ? Icon(
              trailing,
              color: const Color(0xFF718096),
              size: 20,
            )
          : null,
    );
  }
}