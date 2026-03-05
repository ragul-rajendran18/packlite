import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const PackLiteApp());
}

class PackLiteApp extends StatelessWidget {
  const PackLiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}