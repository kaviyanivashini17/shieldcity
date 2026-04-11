import 'package:flutter/material.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});
  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen>
    with SingleTickerProviderStateMixin {
  int _countdown = 10;
  bool _sosSent = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.1)
        .animate(_pulseController);
    _startCountdown();
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      if (_countdown > 1) {
        setState(() => _countdown--);
        return true;
      } else {
        setState(() => _sosSent = true);
        return false;
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1C1F2E),
                    ),
                    child: const Icon(Icons.close,
                        color: Color(0xFF8F97B2), size: 16),
                  ),
                ),
              ),
              const Spacer(),
              AnimatedBuilder(
                animation: _pulseAnim,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnim.value,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFFC9323F), width: 2),
                        color:
                            const Color(0xFFC9323F).withOpacity(0.1),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFC9323F)
                                .withOpacity(0.3),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: _sosSent
                            ? const Icon(Icons.check,
                                color: Color(0xFFC9323F), size: 60)
                            : Text(
                                _countdown.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 64,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                _sosSent ? 'Alert Sent!' : 'SOS Activated',
                style: const TextStyle(
                    color: Color(0xFFC9323F),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _sosSent
                    ? 'Your trusted contacts have been notified'
                    : 'Sending alert in $_countdown seconds',
                style: const TextStyle(
                    color: Color(0xFF8F97B2), fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2ECC8E).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color(0xFF2ECC8E).withOpacity(0.2)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on,
                        color: Color(0xFF2ECC8E), size: 16),
                    SizedBox(width: 6),
                    Text('12.9716, 77.5946 · Bengaluru',
                        style: TextStyle(
                            color: Color(0xFF2ECC8E), fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF25D366).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFF25D366)
                                .withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          const Text('Amma',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                          Text(
                              _sosSent
                                  ? '✅ Notified'
                                  : 'Notifying...',
                              style: const TextStyle(
                                  color: Color(0xFF25D366),
                                  fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF25D366).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFF25D366)
                                .withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          const Text('Rekha',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                          Text(
                              _sosSent
                                  ? '✅ Notified'
                                  : 'Notifying...',
                              style: const TextStyle(
                                  color: Color(0xFF25D366),
                                  fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (_sosSent)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2ECC8E).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color:
                              const Color(0xFF2ECC8E).withOpacity(0.3)),
                    ),
                    child: const Text('✅ False Alarm — I am safe',
                        style: TextStyle(
                            color: Color(0xFF2ECC8E),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ),
              if (!_sosSent)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1F2E),
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: const Color(0xFF2A2D3E)),
                    ),
                    child: const Text(
                        '✕ Cancel — This was a mistake',
                        style: TextStyle(
                            color: Color(0xFF8F97B2), fontSize: 14),
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
}