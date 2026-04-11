import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _editMode = false;
  final TextEditingController _nameController =
      TextEditingController(text: 'Priya Sharma');
  final TextEditingController _cityController =
      TextEditingController(text: 'Bengaluru');

  bool _powerButtonSOS = true;
  bool _volumeButtonSOS = true;
  bool _shakeToSOS = false;
  bool _alwaysOnSafety = true;
  bool _weeklyDigest = true;

  final List<Map<String, dynamic>> _contacts = [
    {
      'name': 'Amma',
      'relation': 'Mother',
      'phone': '+91 98700 11111',
      'color': 0xFFE84C5A,
    },
    {
      'name': 'Rekha',
      'relation': 'Friend',
      'phone': '+91 98700 22222',
      'color': 0xFF3B82F6,
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _editMode = !_editMode),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _editMode
                            ? const Color(0xFF2ECC8E)
                            : const Color(0xFF1C1F2E),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _editMode
                              ? const Color(0xFF2ECC8E)
                              : const Color(0xFF2A2D3E),
                        ),
                      ),
                      child: Text(
                        _editMode ? '✓ Save' : '✎ Edit',
                        style: TextStyle(
                          color: _editMode
                              ? Colors.white
                              : const Color(0xFF8F97B2),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Avatar section
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFC9323F)
                          .withOpacity(0.12),
                      border: Border.all(
                          color: const Color(0xFFC9323F),
                          width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        _nameController.text.isNotEmpty
                            ? _nameController.text[0]
                                .toUpperCase()
                            : 'P',
                        style: const TextStyle(
                          color: Color(0xFFC9323F),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          _nameController.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '+91 98765 43210 · Verified ✓',
                          style: TextStyle(
                            color: Color(0xFF8F97B2),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2ECC8E)
                                .withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xFF2ECC8E)
                                    .withOpacity(0.3)),
                          ),
                          child: const Text(
                            '👩 Woman — Full Access',
                            style: TextStyle(
                                color: Color(0xFF2ECC8E),
                                fontSize: 9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Personal info
              _sectionLabel('PERSONAL INFO'),
              const SizedBox(height: 10),
              _infoCard([
                _infoRow('👤', 'Name', _nameController,
                    _editMode),
                _infoRow('📍', 'City', _cityController,
                    _editMode),
                _infoRowStatic(
                    '📱', 'Phone', '+91 98765 43210'),
              ]),

              const SizedBox(height: 20),

              // Trusted circle
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  _sectionLabel('TRUSTED CIRCLE'),
                  if (_contacts.length < 3)
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        '+ Add',
                        style: TextStyle(
                            color: Color(0xFFC9323F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              ..._contacts.map((contact) =>
                  _contactCard(contact)),
              if (_contacts.length < 3)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF2A2D3E),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add,
                          color: Color(0xFF5A6282), size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'Add Contact (${3 - _contacts.length} remaining)',
                        style: const TextStyle(
                            color: Color(0xFF5A6282),
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              // SOS Settings
              _sectionLabel('SOS SETTINGS'),
              const SizedBox(height: 10),
              _settingsCard([
                _toggleRow(
                  '🔘',
                  'Power button SOS',
                  'Press 5 times to trigger',
                  _powerButtonSOS,
                  (v) => setState(() => _powerButtonSOS = v),
                ),
                _toggleRow(
                  '🔊',
                  'Volume button SOS',
                  'Press 3 times to trigger',
                  _volumeButtonSOS,
                  (v) => setState(() => _volumeButtonSOS = v),
                ),
                _toggleRow(
                  '📳',
                  'Shake to SOS',
                  'Shake phone 3 times',
                  _shakeToSOS,
                  (v) => setState(() => _shakeToSOS = v),
                ),
              ]),

              const SizedBox(height: 20),

              // Safety Settings
              _sectionLabel('SAFETY SETTINGS'),
              const SizedBox(height: 10),
              _settingsCard([
                _toggleRow(
                  '🛡️',
                  'Always On Safety',
                  'SOS ready even when app is closed',
                  _alwaysOnSafety,
                  (v) =>
                      setState(() => _alwaysOnSafety = v),
                ),
                _toggleRow(
                  '📊',
                  'Weekly Safety Digest',
                  'Sunday summary of your area',
                  _weeklyDigest,
                  (v) =>
                      setState(() => _weeklyDigest = v),
                ),
              ]),

              const SizedBox(height: 20),

              // Trust score
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1F2E),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: const Color(0xFFC9323F)
                          .withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFC9323F)
                            .withOpacity(0.1),
                        border: Border.all(
                            color: const Color(0xFFC9323F)
                                .withOpacity(0.3)),
                      ),
                      child: const Center(
                        child: Text(
                          '42',
                          style: TextStyle(
                            color: Color(0xFFC9323F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Community Trust Score',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: 0.42,
                              backgroundColor:
                                  const Color(0xFF2A2D3E),
                              valueColor:
                                  const AlwaysStoppedAnimation(
                                      Color(0xFFC9323F)),
                              minHeight: 4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'File more reports to increase trust',
                            style: TextStyle(
                                color: Color(0xFF5A6282),
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Sign out
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1F2E),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: const Color(0xFF2A2D3E)),
                  ),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                        color: Color(0xFF8F97B2),
                        fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF5A6282),
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F2E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: children),
    );
  }

  Widget _infoRow(String icon, String label,
      TextEditingController controller, bool editMode) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Color(0xFF2A2D3E))),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: Color(0xFF5A6282), fontSize: 9)),
                editMode
                    ? TextField(
                        controller: controller,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      )
                    : Text(
                        controller.text,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRowStatic(
      String icon, String label, String value) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: Color(0xFF5A6282), fontSize: 9)),
                Text(value,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactCard(Map<String, dynamic> contact) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color(0xFF2ECC8E).withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(contact['color'] as int),
            ),
            child: Center(
              child: Text(
                (contact['name'] as String)[0],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact['name'] as String,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
                Text(
                    '${contact['relation']} · ${contact['phone']}',
                    style: const TextStyle(
                        color: Color(0xFF2ECC8E),
                        fontSize: 10)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              color: Color(0xFF5A6282), size: 18),
        ],
      ),
    );
  }

  Widget _settingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F2E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: children),
    );
  }

  Widget _toggleRow(
    String icon,
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: Color(0xFF2A2D3E), width: 0.5)),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
                Text(subtitle,
                    style: const TextStyle(
                        color: Color(0xFF5A6282),
                        fontSize: 10)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFC9323F),
            activeTrackColor:
                const Color(0xFFC9323F).withOpacity(0.3),
            inactiveThumbColor: const Color(0xFF5A6282),
            inactiveTrackColor: const Color(0xFF2A2D3E),
          ),
        ],
      ),
    );
  }
}