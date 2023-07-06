import 'package:flutter/material.dart';
import 'package:lms/navigation/StudentsPanel/students_bottom_tabas.dart';
import 'package:lms/screens/root/landing_screen.dart';

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
      child: const StudentsBottomTabs(defaultPageIndex: 2),
    );
  }
}
