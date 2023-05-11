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
          title: const Text(
            'فاواگستر سپهر',
            style: TextStyle(color: Colors.black),
          ),
          automaticallyImplyLeading: false,
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.home_outlined, color: Colors.blue),
          title: const Text(
            'صفحه‌اصلی',
          ),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
          },
        ),
        // const Divider(),
        ListTile(
          leading: const Icon(Icons.person_2),
          title: const Text(
            'فراگیران',
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(
            'مدرسین',
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(
            'رابطین آموزشی',
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.question_answer, color: Colors.orange),
          title: const Text(
            'رابطین پژوهشی',
          ),
          onTap: () {},
        ),
      ]),
    );
  }
}
