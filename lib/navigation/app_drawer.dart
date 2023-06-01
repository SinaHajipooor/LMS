import 'package:flutter/material.dart';
import '../screens/landing_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  //----------------- UI ------------------

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text('سیستم یادگیری الکترونیک', style: TextStyle(color: Colors.black, fontSize: 16)),
          automaticallyImplyLeading: false,
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.home_outlined, color: Colors.blue),
          title: const Text('صفحه‌اصلی'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
          },
        ),
        // const Divider(),
        ListTile(
          leading: const Icon(Icons.person_2),
          title: const Text('فراگیران'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('مدرسین'),
          onTap: () {},
        ),
      ]),
    );
  }
}
