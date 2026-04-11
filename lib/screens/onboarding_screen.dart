import 'package:flutter/material.dart';
import 'question_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'icon': Icons.map_outlined,
      'title': 'Know Your City',
      'desc': 'Real time AI safety scores for every area in Bengaluru. Green is safe. Red means stay alert. Always updated by the community.',
    },
    {
      'icon': Icons.shield_outlined,
      'title': 'Your Journey. Your Control.',
      'desc': 'Let the people you trust know you are on your way home safely — only when YOU choose. No tracking without your permission.',
    },
    {
      'icon': Icons.sos_outlined,
      'title': 'Help in One Tap',
      'desc': 'SOS button always ready. One tap sends your location to trusted contacts via SMS and WhatsApp instantly.',
    },
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const QuestionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const QuestionScreen()),
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Color(0xFF5A6282), fontSize: 14),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xFFC9323F).withOpacity(0.1),
                            border: Border.all(
                              color: const Color(0xFFC9323F).withOpacity(0.3),
                            ),
                          ),
                          child: Icon(
                            slide['icon'] as IconData,
                            color: const Color(0xFFC9323F),
                            size: 48,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          slide['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          slide['desc'] as String,
                          style: const TextStyle(
                            color: Color(0xFF8F97B2),
                            fontSize: 14,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == i
                        ? const Color(0xFFC9323F)
                        : const Color(0xFF1C1F2E),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: _nextPage,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC9323F),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    _currentPage == _slides.length - 1 ? 'Get Started →' : 'Next →',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

