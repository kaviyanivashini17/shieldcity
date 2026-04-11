import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'sos_screen.dart';
import 'safety_tools_screen.dart';
import 'report_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  Map<String, dynamic>? _selectedZone;

  final List<Map<String, dynamic>> _zones = [
    {'name': 'Koramangala', 'score': 82, 'lat': 12.9352, 'lng': 77.6245},
    {'name': 'HSR Layout', 'score': 80, 'lat': 12.9116, 'lng': 77.6389},
    {'name': 'Indiranagar', 'score': 75, 'lat': 12.9784, 'lng': 77.6408},
    {'name': 'Jayanagar', 'score': 78, 'lat': 12.9308, 'lng': 77.5831},
    {'name': 'Whitefield', 'score': 72, 'lat': 12.9698, 'lng': 77.7499},
    {'name': 'BTM Layout', 'score': 65, 'lat': 12.9166, 'lng': 77.6101},
    {'name': 'MG Road', 'score': 60, 'lat': 12.9757, 'lng': 77.6011},
    {'name': 'Silk Board', 'score': 58, 'lat': 12.9176, 'lng': 77.6227},
    {'name': 'Electronic City', 'score': 68, 'lat': 12.8458, 'lng': 77.6603},
    {'name': 'Marathahalli', 'score': 64, 'lat': 12.9591, 'lng': 77.6974},
    {'name': 'Majestic', 'score': 38, 'lat': 12.9774, 'lng': 77.5713},
    {'name': 'KR Market', 'score': 48, 'lat': 12.9634, 'lng': 77.5855},
    {'name': 'Shivajinagar', 'score': 45, 'lat': 12.9849, 'lng': 77.6011},
    {'name': 'Yeshwanthpur', 'score': 55, 'lat': 13.0234, 'lng': 77.5540},
    {'name': 'Hebbal', 'score': 70, 'lat': 13.0350, 'lng': 77.5970},
  ];

  Color _zoneColor(int score) {
    if (score >= 70) return const Color(0xFF2ECC8E);
    if (score >= 50) return const Color(0xFFE8923A);
    return const Color(0xFFC9323F);
  }

  String _zoneTime(int score) {
    if (score >= 70) return 'Safe most times';
    if (score >= 50) return 'Caution after 9pm';
    return 'Avoid after 8pm';
  }

  String _zoneReason(int score) {
    if (score >= 70) return 'Active community, good lighting';
    if (score >= 50) return 'Mixed safety — careful at night';
    return 'Poor lighting, crowded area';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: Stack(
        children: [
          // Main content
          _currentTab == 0
              ? _buildMap()
              : _currentTab == 1
                  ? const SafetyToolsScreen()
                  : _currentTab == 2
                      ? const ReportScreen()
                      : const ProfileScreen(),

          // Zone insight card
          if (_selectedZone != null && _currentTab == 0)
            _buildInsightCard(),

          // Floating SOS button
          if (_currentTab == 0)
            Positioned(
              bottom: 80,
              right: 16,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SOSScreen()),
                ),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFC9323F),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFC9323F).withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SOS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1)),
                      Text('tap',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 8)),
                    ],
                  ),
                ),
              ),
            ),

          // Bottom navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(12.9716, 77.5946),
            initialZoom: 12,
            onTap: (_, __) => setState(() => _selectedZone = null),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c', 'd'],
              userAgentPackageName: 'com.example.shieldcity',
            ),
            CircleLayer(
              circles: _zones.map((zone) {
                final color = _zoneColor(zone['score'] as int);
                return CircleMarker(
                  point: LatLng(
                      zone['lat'] as double, zone['lng'] as double),
                  radius: 600,
                  useRadiusInMeter: true,
                  color: color.withOpacity(0.25),
                  borderColor: color.withOpacity(0.7),
                  borderStrokeWidth: 1.5,
                );
              }).toList(),
            ),
            MarkerLayer(
              markers: _zones.map((zone) {
                final score = zone['score'] as int;
                final color = _zoneColor(score);
                return Marker(
                  point: LatLng(
                      zone['lat'] as double, zone['lng'] as double),
                  width: 60,
                  height: 40,
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _selectedZone = zone),
                    child: Column(
                      children: [
                        Text(score.toString(),
                            style: TextStyle(
                                color: color,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text(
                            zone['name']
                                .toString()
                                .split(' ')[0],
                            style: TextStyle(
                                color: color.withOpacity(0.8),
                                fontSize: 8)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: const LatLng(12.9352, 77.6245),
                  width: 20,
                  height: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                          color: const Color(0xFF3B82F6), width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        // Top bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF060D18).withOpacity(0.95),
                  Colors.transparent,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Shield',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: 'City',
                          style: TextStyle(
                              color: Color(0xFFC9323F),
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B0C10).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFFC9323F).withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFC9323F)),
                      ),
                      const SizedBox(width: 5),
                      const Text('AI Live',
                          style: TextStyle(
                              color: Color(0xFF8F97B2), fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // My zone banner
        Positioned(
          bottom: 80,
          left: 16,
          right: 90,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0B0C10).withOpacity(0.92),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: const Color(0xFF2ECC8E).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2ECC8E)),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Koramangala — Safe',
                      style: TextStyle(
                          color: Color(0xFF2ECC8E),
                          fontSize: 11,
                          fontWeight: FontWeight.w500)),
                ),
                const Text('82',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard() {
    final zone = _selectedZone!;
    final score = zone['score'] as int;
    final color = _zoneColor(score);

    return Positioned(
      bottom: 70,
      left: 12,
      right: 12,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF141620),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: color)),
                    const SizedBox(width: 8),
                    Text(zone['name'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    Text('$score/100',
                        style: TextStyle(
                            color: color,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () =>
                          setState(() => _selectedZone = null),
                      child: const Icon(Icons.close,
                          color: Color(0xFF5A6282), size: 18),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: score / 100,
                backgroundColor: const Color(0xFF1C1F2E),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 4,
              ),
            ),
            const SizedBox(height: 12),
            const Text('WHY THIS SCORE',
                style: TextStyle(
                    color: Color(0xFF5A6282),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5)),
            const SizedBox(height: 8),
            _insightRow('🕐', _zoneTime(score)),
            _insightRow('💡', _zoneReason(score)),
            _insightRow('📣',
                '${(score * 0.3).round()} reports this week'),
            const SizedBox(height: 4),
            _insightRow(
              '✅',
              score >= 70
                  ? 'Generally safe — stay aware'
                  : 'Stay on main roads',
              color: const Color(0xFF2ECC8E),
            ),
          ],
        ),
      ),
    );
  }

  Widget _insightRow(String icon, String text,
      {Color color = const Color(0xFF8F97B2)}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 8),
          Expanded(
              child: Text(text,
                  style: TextStyle(color: color, fontSize: 11))),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.map_outlined, 'label': 'Map'},
      {'icon': Icons.shield_outlined, 'label': 'Safety'},
      {'icon': Icons.campaign_outlined, 'label': 'Report'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF0B0C10),
        border: Border(top: BorderSide(color: Color(0xFF1C1F2E))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final active = _currentTab == i;
          return GestureDetector(
            onTap: () => setState(() {
              _currentTab = i;
              _selectedZone = null;
            }),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(items[i]['icon'] as IconData,
                    color: active
                        ? const Color(0xFFC9323F)
                        : const Color(0xFF5A6282),
                    size: 22),
                const SizedBox(height: 2),
                Text(items[i]['label'] as String,
                    style: TextStyle(
                        color: active
                            ? const Color(0xFFC9323F)
                            : const Color(0xFF5A6282),
                        fontSize: 10)),
                if (active)
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFC9323F)),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}