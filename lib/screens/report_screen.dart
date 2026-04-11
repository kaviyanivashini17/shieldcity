import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool _showForm = false;
  int _selectedIncident = -1;
  int _selectedSeverity = -1;

  final List<Map<String, dynamic>> _reports = [
    {
      'area': 'Silk Board Junction',
      'time': '2 hours ago',
      'desc': 'Poor lighting near flyover after 9pm. Stay on main road.',
      'severity': 'high',
      'confirmed': 12,
    },
    {
      'area': 'BTM Layout',
      'time': '5 hours ago',
      'desc': 'Suspicious activity near night market after 10pm.',
      'severity': 'medium',
      'confirmed': 8,
    },
    {
      'area': 'MG Road',
      'time': 'Yesterday',
      'desc': 'Eve teasing reported near bus stop late evening.',
      'severity': 'high',
      'confirmed': 23,
    },
    {
      'area': 'Majestic Bus Stand',
      'time': '2 days ago',
      'desc': 'Crowded and unsafe after 10pm. Avoid if possible.',
      'severity': 'high',
      'confirmed': 31,
    },
    {
      'area': 'Yeshwanthpur',
      'time': '3 days ago',
      'desc': 'Poor street lighting near railway station exit.',
      'severity': 'medium',
      'confirmed': 6,
    },
  ];

  final List<String> _incidents = [
    '😰 Harassment',
    '💡 Poor Lighting',
    '👀 Suspicious',
    '⚠️ Eve Teasing',
    '🚧 Unsafe Road',
    '📍 Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: _showForm ? _buildForm() : _buildFeed(),
      ),
    );
  }

  Widget _buildFeed() {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Community Reports',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2ECC8E).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color:
                              const Color(0xFF2ECC8E).withOpacity(0.2)),
                    ),
                    child: const Text(
                      '👥 247 women keeping area safe',
                      style: TextStyle(
                          color: Color(0xFF2ECC8E), fontSize: 10),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => setState(() => _showForm = true),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC9323F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '+ Report',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: ['All', 'Nearest', 'Recent', 'High Risk']
                .map((filter) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: filter == 'All'
                            ? const Color(0xFFC9323F)
                            : const Color(0xFF1C1F2E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: filter == 'All'
                              ? Colors.white
                              : const Color(0xFF8F97B2),
                          fontSize: 11,
                          fontWeight: filter == 'All'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),

        const SizedBox(height: 12),

        // Report feed
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _reports.length,
            itemBuilder: (context, index) {
              return _buildReportCard(_reports[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    final isHigh = report['severity'] == 'high';
    final color = isHigh
        ? const Color(0xFFC9323F)
        : const Color(0xFFE8923A);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '📍 ${report['area']}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                report['time'] as String,
                style: const TextStyle(
                    color: Color(0xFF5A6282), fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            report['desc'] as String,
            style: const TextStyle(
                color: Color(0xFF8F97B2),
                fontSize: 12,
                height: 1.5),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isHigh ? '🔴 High Risk' : '🟡 Medium',
                  style: TextStyle(color: color, fontSize: 10),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        report['confirmed'] =
                            (report['confirmed'] as int) + 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2ECC8E)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFF2ECC8E)
                                .withOpacity(0.2)),
                      ),
                      child: Text(
                        '✅ ${report['confirmed']} confirmed',
                        style: const TextStyle(
                            color: Color(0xFF2ECC8E),
                            fontSize: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1F2E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '❌ Not accurate',
                        style: TextStyle(
                            color: Color(0xFF5A6282),
                            fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  _showForm = false;
                  _selectedIncident = -1;
                  _selectedSeverity = -1;
                }),
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
              const SizedBox(width: 14),
              const Text(
                'Report Unsafe Area',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC8E).withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: const Color(0xFF2ECC8E).withOpacity(0.2)),
            ),
            child: const Text(
              '🔒 100% Anonymous — your identity is never stored',
              style: TextStyle(
                  color: Color(0xFF2ECC8E), fontSize: 11),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'WHAT HAPPENED?',
            style: TextStyle(
                color: Color(0xFF5A6282),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _incidents.length,
            itemBuilder: (context, i) {
              final selected = _selectedIncident == i;
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedIncident = i),
                child: Container(
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFFC9323F).withOpacity(0.1)
                        : const Color(0xFF1C1F2E),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFFC9323F)
                          : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _incidents[i],
                      style: TextStyle(
                        color: selected
                            ? const Color(0xFFC9323F)
                            : const Color(0xFF8F97B2),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'HOW SERIOUS?',
            style: TextStyle(
                color: Color(0xFF5A6282),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _severityBtn(0, '🟢 Low', const Color(0xFF2ECC8E)),
              const SizedBox(width: 8),
              _severityBtn(
                  1, '🟡 Medium', const Color(0xFFE8923A)),
              const SizedBox(width: 8),
              _severityBtn(2, '🔴 High', const Color(0xFFC9323F)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1F2E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: const Color(0xFF2ECC8E).withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on,
                    color: Color(0xFF2ECC8E), size: 16),
                const SizedBox(width: 8),
                const Text(
                  '📍 Koramangala, Bengaluru',
                  style: TextStyle(
                      color: Color(0xFF2ECC8E), fontSize: 12),
                ),
                const Spacer(),
                const Text('Auto detected',
                    style: TextStyle(
                        color: Color(0xFF5A6282), fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              if (_selectedIncident >= 0 &&
                  _selectedSeverity >= 0) {
                setState(() {
                  _reports.insert(0, {
                    'area': 'Koramangala',
                    'time': 'Just now',
                    'desc':
                        '${_incidents[_selectedIncident]} reported in this area.',
                    'severity': _selectedSeverity == 2
                        ? 'high'
                        : 'medium',
                    'confirmed': 0,
                  });
                  _showForm = false;
                  _selectedIncident = -1;
                  _selectedSeverity = -1;
                });
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: _selectedIncident >= 0 &&
                        _selectedSeverity >= 0
                    ? const Color(0xFFC9323F)
                    : const Color(0xFF1C1F2E),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'Submit Anonymously →',
                style: TextStyle(
                  color: _selectedIncident >= 0 &&
                          _selectedSeverity >= 0
                      ? Colors.white
                      : const Color(0xFF5A6282),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _severityBtn(int index, String label, Color color) {
    final selected = _selectedSeverity == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedSeverity = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? color.withOpacity(0.1)
                : const Color(0xFF1C1F2E),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? color : Colors.transparent,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? color : const Color(0xFF8F97B2),
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
  }
}