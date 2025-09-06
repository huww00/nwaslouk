import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE8F4FD),
            Color(0xFFF0F8FF),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Mock Map Background
          _buildMockMap(),
          
          // Current Location Marker
          const Positioned(
            top: 200,
            left: 180,
            child: CurrentLocationMarker(),
          ),
          
          // Mock Louage Markers
          const Positioned(
            top: 150,
            left: 120,
            child: LouageMarker(
              type: 'Standard',
              seatsAvailable: 3,
              estimatedTime: '5 min',
            ),
          ),
          
          const Positioned(
            top: 280,
            left: 250,
            child: LouageMarker(
              type: 'Comfort',
              seatsAvailable: 2,
              estimatedTime: '8 min',
            ),
          ),
          
          const Positioned(
            top: 320,
            left: 100,
            child: LouageMarker(
              type: 'Standard',
              seatsAvailable: 4,
              estimatedTime: '12 min',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockMap() {
    return CustomPaint(
      size: Size.infinite,
      painter: MapPainter(),
    );
  }
}

class CurrentLocationMarker extends StatelessWidget {
  const CurrentLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: const Color(0xFF4285F4),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4285F4).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }
}

class LouageMarker extends StatelessWidget {
  final String type;
  final int seatsAvailable;
  final String estimatedTime;

  const LouageMarker({
    super.key,
    required this.type,
    required this.seatsAvailable,
    required this.estimatedTime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show louage details
        _showLouageDetails(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE53E3E), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.directions_car,
              color: const Color(0xFFE53E3E),
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              '$seatsAvailable',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE53E3E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLouageDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.directions_car,
                  color: const Color(0xFFE53E3E),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  '$type Louage',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoChip(Icons.event_seat, '$seatsAvailable seats'),
                const SizedBox(width: 12),
                _buildInfoChip(Icons.access_time, estimatedTime),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle booking
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53E3E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Book This Louage',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
          Icon(icon, size: 16, color: const Color(0xFF718096)),
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

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw mock streets
    final path = Path();
    
    // Horizontal streets
    for (int i = 0; i < 8; i++) {
      final y = (size.height / 8) * i;
      path.moveTo(0, y);
      path.lineTo(size.width, y);
    }
    
    // Vertical streets
    for (int i = 0; i < 6; i++) {
      final x = (size.width / 6) * i;
      path.moveTo(x, 0);
      path.lineTo(x, size.height);
    }
    
    canvas.drawPath(path, paint);
    
    // Draw some mock buildings/blocks
    final buildingPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..style = PaintingStyle.fill;
    
    final buildings = [
      Rect.fromLTWH(50, 80, 80, 60),
      Rect.fromLTWH(200, 120, 100, 80),
      Rect.fromLTWH(80, 250, 120, 70),
      Rect.fromLTWH(250, 300, 90, 90),
    ];
    
    for (final building in buildings) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(building, const Radius.circular(8)),
        buildingPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}