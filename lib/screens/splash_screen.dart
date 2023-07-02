import 'package:flutter/material.dart';
import 'package:lms/screens/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (_, __, ___) => const LandingScreen(),
          transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0.0, // Define the initial opacity of the child widget
                end: 1.0, // Define the final opacity of the child widget
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/splash.png', fit: BoxFit.cover),
          ),
          Center(
            child: Image.asset('assets/images/avatar-edu.png'),
          )
        ],
      ),
    );
  }
}
