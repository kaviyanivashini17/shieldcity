import 'package:flutter/material.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  void _sendOTP() {
    if (_phoneController.text.length == 10) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => OTPScreen(
                phoneNumber: _phoneController.text,
              ),
            ),
          );
        }
      });
    }
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
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFFC9323F), width: 2),
                        color: const Color(0xFFC9323F).withOpacity(0.1),
                      ),
                      child: const Icon(Icons.shield,
                          color: Color(0xFFC9323F), size: 34),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Shield',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'City',
                            style: TextStyle(
                                color: Color(0xFFC9323F),
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Safety for every woman in India',
                      style: TextStyle(
                          color: Color(0xFF5A6282), fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              const Text(
                'Enter your mobile number',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'We will send a one time password to verify',
                style: TextStyle(color: Color(0xFF5A6282), fontSize: 13),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1F2E),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: const Color(0xFFC9323F).withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                            right: BorderSide(color: Color(0xFF2A2D3E))),
                      ),
                      child: const Text('🇮🇳 +91',
                          style: TextStyle(
                              color: Color(0xFF8F97B2),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 2),
                        decoration: const InputDecoration(
                          hintText: 'Enter 10 digit number',
                          hintStyle: TextStyle(
                              color: Color(0xFF5A6282),
                              fontSize: 14,
                              letterSpacing: 0),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          counterText: '',
                        ),
                        onChanged: (v) => setState(() {}),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _sendOTP,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: _phoneController.text.length == 10
                        ? const Color(0xFFC9323F)
                        : const Color(0xFF1C1F2E),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          ),
                        )
                      : Text(
                          'Send OTP →',
                          style: TextStyle(
                            color: _phoneController.text.length == 10
                                ? Colors.white
                                : const Color(0xFF5A6282),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Free forever · No credit card needed',
                      style: TextStyle(
                          color: Color(0xFF5A6282), fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'By continuing you agree to our ',
                            style: TextStyle(
                                color: Color(0xFF5A6282), fontSize: 11),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                                color: Color(0xFFC9323F), fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
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