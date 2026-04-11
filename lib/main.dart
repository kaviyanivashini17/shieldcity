import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ShieldCityApp());
}

class ShieldCityApp extends StatelessWidget {
  const ShieldCityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShieldCity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0B0C10),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}