import 'package:flutter/material.dart';
import 'package:lms/screens/root/landing_screen.dart';

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
                begin: 0.0,
                end: 1.0,
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
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/images/splash.jpg', fit: BoxFit.cover),
            ),
            Center(
              child: Image.asset('assets/images/avatar-edu.png'),
            )
          ],
        ),
      ),
    );
  }
}
