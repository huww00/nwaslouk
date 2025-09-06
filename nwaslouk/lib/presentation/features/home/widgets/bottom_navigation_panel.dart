import 'package:flutter/material.dart';

class BottomNavigationPanel extends StatelessWidget {
  final VoidCallback onLouageTypeTap;

  const BottomNavigationPanel({
    super.key,
    required this.onLouageTypeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Louage Types Button
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: onLouageTypeTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions_car,
                        color: Color(0xFFE53E3E),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Louage Types',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Navigation Items
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    icon: Icons.home,
                    label: 'Home',
                    isActive: true,
                    onTap: () {},
                  ),
                  _buildNavItem(
                    icon: Icons.history,
                    label: 'Trips',
                    isActive: false,
                    onTap: () {},
                  ),
                  _buildNavItem(
                    icon: Icons.account_wallet,
                    label: 'Wallet',
                    isActive: false,
                    onTap: () {},
                  ),
                  _buildNavItem(
                    icon: Icons.person,
                    label: 'Profile',
                    isActive: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFFE53E3E) : const Color(0xFF718096),
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isActive ? const Color(0xFFE53E3E) : const Color(0xFF718096),
            ),
          ),
        ],
      ),
    );
  }
}