import 'package:flutter/material.dart';
import '../navigation/app_bottom_tabs.dart';

class HomeScreen extends StatelessWidget {
  // --------------- feilds -----------------
  static const routeName = '/home-screen';

  const HomeScreen({super.key});
// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBottomTabs(),
    );
  }
}
