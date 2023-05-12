import 'package:flutter/material.dart';
import 'package:lms/screens/landing_screen.dart';
import '../navigation/app_bottom_tabs.dart';

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
      child: Scaffold(
        body: AppBottomTabs(),
      ),
    );
  }
}
