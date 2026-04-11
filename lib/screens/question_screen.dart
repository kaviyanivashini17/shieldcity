import 'package:flutter/material.dart';
import 'login_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _selected = -1;

  final List<Map<String, dynamic>> _options = [
    {'icon': '🌙', 'text': 'Late night travel'},
    {'icon': '🚌', 'text': 'Daily commute'},
    {'icon': '🚶', 'text': 'Walking alone'},
    {'icon': '🎓', 'text': 'College campus'},
  ];

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
              const SizedBox(height: 20),
              const Text(
                'One quick question',
                style: TextStyle(color: Color(0xFF8F97B2), fontSize: 14),
              ),
              const SizedBox(height: 8),
              const Text(
                'What is your biggest safety concern?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This helps us personalize your experience',
                style: TextStyle(color: Color(0xFF5A6282), fontSize: 13),
              ),
              const SizedBox(height: 32),
              ...List.generate(
                _options.length,
                (i) => GestureDetector(
                  onTap: () => setState(() => _selected = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selected == i
                          ? const Color(0xFFC9323F).withOpacity(0.1)
                          : const Color(0xFF1C1F2E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selected == i
                            ? const Color(0xFFC9323F)
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(_options[i]['icon'] as String,
                            style: const TextStyle(fontSize: 24)),
                        const SizedBox(width: 16),
                        Text(
                          _options[i]['text'] as String,
                          style: TextStyle(
                            color: _selected == i
                                ? Colors.white
                                : const Color(0xFF8F97B2),
                            fontSize: 15,
                            fontWeight: _selected == i
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        const Spacer(),
                        if (_selected == i)
                          const Icon(Icons.check_circle,
                              color: Color(0xFFC9323F), size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: _selected >= 0
                        ? const Color(0xFFC9323F)
                        : const Color(0xFF1C1F2E),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    _selected >= 0 ? 'Continue →' : 'Skip for now',
                    style: TextStyle(
                      color: _selected >= 0
                          ? Colors.white
                          : const Color(0xFF5A6282),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}