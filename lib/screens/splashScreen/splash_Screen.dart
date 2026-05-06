import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie/screens/bottomnav/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(),
    ));
  });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/Logo.png', height: 120),
                const SizedBox(height: 20),
                const Text(
                  'Movie App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Discover your next favorite movie',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 30),

                const CircularProgressIndicator(
                  color: Colors.red,
                ),
              ]
            )
          )
        ),
      )
    );
  }
}