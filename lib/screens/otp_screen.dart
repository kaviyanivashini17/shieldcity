import 'package:flutter/material.dart';
import 'home_screen.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen({super.key, required this.phoneNumber});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(6, (_) => FocusNode());
  bool _isLoading = false;
  int _resendSeconds = 60;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
        return true;
      }
      return false;
    });
  }

  String get _otp =>
      _controllers.map((c) => c.text).join();

  void _verifyOTP() {
    if (_otp.length == 6) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    for (var f in _focusNodes) f.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
              const SizedBox(height: 32),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color(0xFFC9323F), width: 2),
                  color: const Color(0xFFC9323F).withOpacity(0.1),
                ),
                child: const Icon(Icons.shield,
                    color: Color(0xFFC9323F), size: 28),
              ),
              const SizedBox(height: 20),
              const Text(
                'Verify your number',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter the 6 digit OTP sent to\n+91 ${widget.phoneNumber}',
                style: const TextStyle(
                  color: Color(0xFF8F97B2),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) {
                  return SizedBox(
                    width: 44,
                    height: 54,
                    child: TextField(
                      controller: _controllers[i],
                      focusNode: _focusNodes[i],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: const Color(0xFF1C1F2E),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFFC9323F), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: _controllers[i].text.isNotEmpty
                                ? const Color(0xFFC9323F)
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onChanged: (v) {
                        if (v.isNotEmpty && i < 5) {
                          _focusNodes[i + 1].requestFocus();
                        }
                        if (v.isEmpty && i > 0) {
                          _focusNodes[i - 1].requestFocus();
                        }
                        setState(() {});
                        if (_otp.length == 6) _verifyOTP();
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: _verifyOTP,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: _otp.length == 6
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
                          'Verify and Join →',
                          style: TextStyle(
                            color: _otp.length == 6
                                ? Colors.white
                                : const Color(0xFF5A6282),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: _resendSeconds > 0
                    ? Text(
                        'Resend OTP in ${_resendSeconds}s',
                        style: const TextStyle(
                            color: Color(0xFF5A6282), fontSize: 13),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() => _resendSeconds = 60);
                          _startResendTimer();
                        },
                        child: const Text(
                          'Resend OTP',
                          style: TextStyle(
                            color: Color(0xFFC9323F),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
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