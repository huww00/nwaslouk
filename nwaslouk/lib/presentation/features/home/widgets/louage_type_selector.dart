import 'package:flutter/material.dart';

class LouageTypeSelector extends StatelessWidget {
  final VoidCallback onClose;
  final Function(String) onTypeSelected;

  const LouageTypeSelector({
    super.key,
    required this.onClose,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle Bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Choose Louage Type',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFF718096),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Louage Types List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildLouageTypeCard(
                    type: 'Standard',
                    description: 'Affordable rides for everyday travel',
                    price: '3-5 TND',
                    capacity: '8-9 passengers',
                    icon: Icons.directions_car,
                    color: const Color(0xFF4285F4),
                    estimatedTime: '5-10 min',
                    onTap: () => onTypeSelected('standard'),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildLouageTypeCard(
                    type: 'Comfort',
                    description: 'More comfortable with air conditioning',
                    price: '6-8 TND',
                    capacity: '6-7 passengers',
                    icon: Icons.drive_eta,
                    color: const Color(0xFFE53E3E),
                    estimatedTime: '3-8 min',
                    onTap: () => onTypeSelected('comfort'),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildLouageTypeCard(
                    type: 'Express',
                    description: 'Direct routes with fewer stops',
                    price: '8-12 TND',
                    capacity: '4-5 passengers',
                    icon: Icons.speed,
                    color: const Color(0xFF10B981),
                    estimatedTime: '2-5 min',
                    onTap: () => onTypeSelected('express'),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildLouageTypeCard(
                    type: 'Intercity',
                    description: 'Long-distance travel between cities',
                    price: '15-25 TND',
                    capacity: '8-12 passengers',
                    icon: Icons.alt_route,
                    color: const Color(0xFF8B5CF6),
                    estimatedTime: '10-20 min',
                    onTap: () => onTypeSelected('intercity'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLouageTypeCard({
    required String type,
    required String description,
    required String price,
    required String capacity,
    required IconData icon,
    required Color color,
    required String estimatedTime,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF718096),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      estimatedTime,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                _buildInfoChip(Icons.people, capacity),
                const SizedBox(width: 12),
                _buildInfoChip(Icons.access_time, 'Available now'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF718096)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF718096),
            ),
          ),
        ],
      ),
    );
  }
}