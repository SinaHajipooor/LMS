import 'package:flutter/material.dart';
import 'package:lms/navigation/bottom_tabas.dart';
import 'package:lms/screens/landing_screen.dart';

class HomeScreen extends StatelessWidget {
  // --------------- feilds -----------------
  static const routeName = '/home-screen';

  const HomeScreen({super.key});
// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
        return false;
      },
      child: const BottomTabs(defaultPageIndex: 2),
    );
  }
}
