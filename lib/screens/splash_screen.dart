import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// App Logo
            const Icon(
              Icons.luggage,
              color: Colors.white,
              size: 80,
            ),

            const SizedBox(height: 20),

            /// App Name
            const Text(
              "PackLite",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Smart Packing for Smart Travel",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),

          ],
        ),
      ),
    );
  }
}