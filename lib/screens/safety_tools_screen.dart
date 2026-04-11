import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SafetyToolsScreen extends StatelessWidget {
  const SafetyToolsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Safety Tools',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Your safety. Your control.',
                style: TextStyle(
                  color: Color(0xFF5A6282),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 24),

              // Journey Mode Card
              _ToolCard(
                icon: Icons.shield_outlined,
                iconColor: const Color(0xFF3B82F6),
                title: 'Journey Mode',
                description:
                    'Share your live route with trusted contacts. They watch you reach home safely — only when you choose.',
                tag: 'Live Tracking',
                tagColor: const Color(0xFF3B82F6),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const JourneyScreen()),
                ),
              ),

              const SizedBox(height: 14),

              // Safe Walk Card
              _ToolCard(
                icon: Icons.directions_walk,
                iconColor: const Color(0xFF2ECC8E),
                title: 'Safe Walk Mode',
                description:
                    'Set a timer for your walk. If you don\'t tap I\'m Safe before it ends — your trusted contacts get auto-alerted.',
                tag: 'Timer Based',
                tagColor: const Color(0xFF2ECC8E),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SafeWalkScreen()),
                ),
              ),

              const SizedBox(height: 14),

              // Fake Call Card
              _ToolCard(
                icon: Icons.phone_outlined,
                iconColor: const Color(0xFFE8923A),
                title: 'Fake Call',
                description:
                    'Make your phone ring like a real call to deter threats. Looks completely real to anyone nearby.',
                tag: 'Disguise',
                tagColor: const Color(0xFFE8923A),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const FakeCallScreen()),
                ),
              ),

              const SizedBox(height: 24),

              // Tips section
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1F2E),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFC9323F).withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '💡 Quick Tips',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _tipRow('Short walk to car or bus stop',
                        'Safe Walk Mode'),
                    _tipRow('Travelling home late night',
                        'Journey Mode'),
                    _tipRow('Someone following you',
                        'Fake Call'),
                    _tipRow('Immediate danger',
                        'SOS Button → Red circle'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tipRow(String situation, String tool) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Expanded(
            child: Text(
              situation,
              style: const TextStyle(
                color: Color(0xFF8F97B2),
                fontSize: 11,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFC9323F).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFC9323F).withOpacity(0.2),
              ),
            ),
            child: Text(
              tool,
              style: const TextStyle(
                color: Color(0xFFC9323F),
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── TOOL CARD ──────────────────────────────────────────
class _ToolCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String tag;
  final Color tagColor;
  final VoidCallback onTap;

  const _ToolCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.tag,
    required this.tagColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1F2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: iconColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: iconColor.withOpacity(0.3),
                ),
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: tagColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: tagColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF8F97B2),
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              color: iconColor.withOpacity(0.5),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

// ── JOURNEY SCREEN ─────────────────────────────────────
class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});
  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  bool _journeyActive = false;
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  int _progress = 0;

  void _startJourney() {
    if (_fromController.text.isEmpty || _toController.text.isEmpty)
      return;
    setState(() => _journeyActive = true);
    _simulateProgress();
  }

  void _simulateProgress() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted || !_journeyActive) return false;
      if (_progress < 100) {
        setState(() => _progress += 5);
        return true;
      }
      return false;
    });
  }

  void _endJourney() {
    setState(() {
      _journeyActive = false;
      _progress = 0;
      _fromController.clear();
      _toController.clear();
    });
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _journeyActive ? _buildActive() : _buildStart();
  }

  Widget _buildStart() {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1F2E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Journey Mode',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Your journey. Your control.',
                  style: TextStyle(
                      color: Color(0xFF5A6282), fontSize: 14)),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF1C1F2E),
                        border: Border.all(
                            color: const Color(0xFF2A2D3E)),
                      ),
                      child: const Icon(Icons.shield_outlined,
                          color: Color(0xFF5A6282), size: 40),
                    ),
                    const SizedBox(height: 12),
                    const Text('No active journey',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    const Text(
                      'Start a journey to let the\npeople you trust know\nyou are on your way safely',
                      style: TextStyle(
                          color: Color(0xFF8F97B2),
                          fontSize: 12,
                          height: 1.6),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _inputField(_fromController,
                  'Where are you now?', Icons.circle,
                  const Color(0xFF2ECC8E)),
              const SizedBox(height: 12),
              _inputField(_toController,
                  'Where are you going?', Icons.location_on,
                  const Color(0xFFC9323F)),
              const Spacer(),
              GestureDetector(
                onTap: _startJourney,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC9323F),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text('Start Journey →',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller,
      String hint, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
              color: Color(0xFF5A6282), fontSize: 14),
          prefixIcon: Icon(icon, color: color, size: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildActive() {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Journey Mode',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2ECC8E).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color(0xFF2ECC8E)
                              .withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF2ECC8E)),
                        ),
                        const SizedBox(width: 5),
                        const Text('Active',
                            style: TextStyle(
                                color: Color(0xFF2ECC8E),
                                fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(12.9352, 77.6245),
                  initialZoom: 11,
                  interactionOptions: InteractionOptions(
                      flags: InteractiveFlag.none),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c', 'd'],
                    userAgentPackageName: 'com.example.shieldcity',
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: const [
                          LatLng(12.9204, 77.6012),
                          LatLng(12.9176, 77.6227),
                          LatLng(12.9116, 77.6389),
                        ],
                        strokeWidth: 3,
                        gradientColors: const [
                          Color(0xFF2ECC8E),
                          Color(0xFFE8923A),
                          Color(0xFFC9323F),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1F2E),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          _waypoint(
                              '✓', _fromController.text,
                              'Departed', const Color(0xFF2ECC8E),
                              true),
                          _waypoint(
                              '●', 'Silk Board — You are here',
                              'Score 61 — Stay alert',
                              const Color(0xFFC9323F), true),
                          _waypoint(
                              '○', _toController.text,
                              'Score 88 — Safe zone',
                              const Color(0xFF5A6282), false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1F2E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Text('Start',
                              style: TextStyle(
                                  color: Color(0xFF8F97B2),
                                  fontSize: 10)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: _progress / 100,
                                backgroundColor:
                                    const Color(0xFF2A2D3E),
                                valueColor:
                                    const AlwaysStoppedAnimation(
                                        Color(0xFFC9323F)),
                                minHeight: 6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('ETA 8:15 PM',
                              style: TextStyle(
                                  color: Color(0xFF2ECC8E),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1F2E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          _avatar('A', 0xFFE84C5A),
                          _avatar('R', 0xFF3B82F6),
                          const SizedBox(width: 8),
                          const Text('2 people watching live',
                              style: TextStyle(
                                  color: Color(0xFF8F97B2),
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _endJourney,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2ECC8E),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text('I arrived safely →',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _waypoint(String dot, String title,
      String sub, Color color, bool showLine) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Column(
            children: [
              Text(dot,
                  style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              if (showLine)
                Container(
                    width: 1, height: 16,
                    color: const Color(0xFF2A2D3E)),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500)),
                Text(sub,
                    style: TextStyle(
                        color: color, fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(String letter, int color) {
    return Container(
      width: 26,
      height: 26,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(color),
        border: Border.all(
            color: const Color(0xFF1C1F2E), width: 1.5),
      ),
      child: Center(
        child: Text(letter,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// ── SAFE WALK SCREEN ───────────────────────────────────
class SafeWalkScreen extends StatefulWidget {
  const SafeWalkScreen({super.key});
  @override
  State<SafeWalkScreen> createState() => _SafeWalkScreenState();
}

class _SafeWalkScreenState extends State<SafeWalkScreen> {
  int _selectedMinutes = 10;
  int _remainingSeconds = 0;
  bool _walkActive = false;

  final List<int> _options = [5, 10, 15, 30];

  void _startWalk() {
    setState(() {
      _walkActive = true;
      _remainingSeconds = _selectedMinutes * 60;
    });
    _startTimer();
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted || !_walkActive) return false;
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
        return true;
      } else {
        // Auto alert triggered
        return false;
      }
    });
  }

  void _endWalk() {
    setState(() => _walkActive = false);
    Navigator.pop(context);
  }

  String get _timeDisplay {
    final mins = _remainingSeconds ~/ 60;
    final secs = _remainingSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1F2E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Safe Walk Mode',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text(
                'Auto-alert if you don\'t tap safe in time',
                style: TextStyle(
                    color: Color(0xFF5A6282), fontSize: 13),
              ),
              const SizedBox(height: 32),
              if (!_walkActive) ...[
                const Text('Set walk duration:',
                    style: TextStyle(
                        color: Color(0xFF8F97B2), fontSize: 12)),
                const SizedBox(height: 12),
                Row(
                  children: _options.map((min) {
                    final selected = _selectedMinutes == min;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _selectedMinutes = min),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding:
                              const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFF2ECC8E)
                                    .withOpacity(0.1)
                                : const Color(0xFF1C1F2E),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF2ECC8E)
                                  : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            '$min min',
                            style: TextStyle(
                              color: selected
                                  ? const Color(0xFF2ECC8E)
                                  : const Color(0xFF8F97B2),
                              fontSize: 12,
                              fontWeight: selected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              if (_walkActive) ...[
                Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color(0xFFC9323F), width: 3),
                      color: const Color(0xFFC9323F).withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _timeDisplay,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('remaining',
                            style: TextStyle(
                                color: Color(0xFF8F97B2),
                                fontSize: 11)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1F2E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: const Color(0xFFC9323F).withOpacity(0.2)),
                  ),
                  child: const Text(
                    'If timer reaches 0 — Amma and Rekha get auto-alerted with your last known location.',
                    style: TextStyle(
                        color: Color(0xFF8F97B2),
                        fontSize: 11,
                        height: 1.6),
                  ),
                ),
              ],
              const Spacer(),
              if (_walkActive)
                GestureDetector(
                  onTap: _endWalk,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2ECC8E),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text('✅ I\'m Safe — End Walk',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ),
              if (!_walkActive)
                GestureDetector(
                  onTap: _startWalk,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2ECC8E),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      'Start $_selectedMinutes Minute Walk →',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ── FAKE CALL SCREEN ───────────────────────────────────
class FakeCallScreen extends StatefulWidget {
  const FakeCallScreen({super.key});
  @override
  State<FakeCallScreen> createState() => _FakeCallScreenState();
}

class _FakeCallScreenState extends State<FakeCallScreen>
    with SingleTickerProviderStateMixin {
  bool _callActive = false;
  late AnimationController _ringController;
  late Animation<double> _ringAnim;
  int _callSeconds = 0;

  final List<Map<String, dynamic>> _contacts = [
    {'name': 'Amma', 'relation': 'Mother', 'color': 0xFFE84C5A},
    {'name': 'Rekha', 'relation': 'Friend', 'color': 0xFF3B82F6},
    {'name': 'Priya', 'relation': 'Sister', 'color': 0xFF8B5CF6},
  ];
  int _selectedContact = 0;

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    _ringAnim =
        Tween<double>(begin: 1.0, end: 1.1).animate(_ringController);
  }

  void _startCall() {
    setState(() {
      _callActive = true;
      _callSeconds = 0;
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted || !_callActive) return false;
      setState(() => _callSeconds++);
      return true;
    });
  }

  void _endCall() {
    setState(() => _callActive = false);
    Navigator.pop(context);
  }

  String get _callDuration {
    final mins = _callSeconds ~/ 60;
    final secs = _callSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _ringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_callActive) return _buildActiveCall();
    return _buildSetup();
  }

  Widget _buildSetup() {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1F2E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Fake Call',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text(
                'Looks like a real incoming call to anyone nearby',
                style: TextStyle(
                    color: Color(0xFF5A6282), fontSize: 13),
              ),
              const SizedBox(height: 32),
              const Text('Who is calling you?',
                  style: TextStyle(
                      color: Color(0xFF8F97B2), fontSize: 12)),
              const SizedBox(height: 12),
              ...List.generate(_contacts.length, (i) {
                final contact = _contacts[i];
                final selected = _selectedContact == i;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedContact = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: selected
                          ? Color(contact['color'] as int)
                              .withOpacity(0.1)
                          : const Color(0xFF1C1F2E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? Color(contact['color'] as int)
                                .withOpacity(0.5)
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(contact['color'] as int),
                          ),
                          child: Center(
                            child: Text(
                              (contact['name'] as String)[0],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(contact['name'] as String,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              Text(contact['relation'] as String,
                                  style: const TextStyle(
                                      color: Color(0xFF8F97B2),
                                      fontSize: 11)),
                            ],
                          ),
                        ),
                        if (selected)
                          Icon(Icons.check_circle,
                              color:
                                  Color(contact['color'] as int),
                              size: 20),
                      ],
                    ),
                  ),
                );
              }),
              const Spacer(),
              GestureDetector(
                onTap: _startCall,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2ECC8E),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Trigger Fake Call from ${_contacts[_selectedContact]['name']} →',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveCall() {
    final contact = _contacts[_selectedContact];
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              AnimatedBuilder(
                animation: _ringAnim,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _ringAnim.value,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(contact['color'] as int),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color(contact['color'] as int)
                                    .withOpacity(0.4),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          (contact['name'] as String)[0],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                contact['name'] as String,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                _callSeconds == 0
                    ? 'Incoming call...'
                    : _callDuration,
                style: const TextStyle(
                    color: Color(0xFF8F97B2), fontSize: 14),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'ShieldCity Fake Call — looks real to anyone nearby',
                  style: TextStyle(
                      color: Color(0xFF5A6282), fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: _endCall,
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE84C5A)),
                          child: const Icon(Icons.call_end,
                              color: Colors.white, size: 28),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text('End',
                          style: TextStyle(
                              color: Color(0xFF8F97B2),
                              fontSize: 11)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF2ECC8E)),
                        child: const Icon(Icons.call,
                            color: Colors.white, size: 28),
                      ),
                      const SizedBox(height: 6),
                      const Text('Answer',
                          style: TextStyle(
                              color: Color(0xFF8F97B2),
                              fontSize: 11)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}