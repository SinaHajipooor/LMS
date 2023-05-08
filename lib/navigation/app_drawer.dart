import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/landing_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../providers/Auth/AuthProvider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  //----------------- method ------------------
  _showAlert(BuildContext context) {
    Alert(
            context: context,
            type: AlertType.warning,
            title: "خروج از حساب ",
            desc: "آیا مطمعن هستید که از حساب خود خارج می‌شوید ؟",
            style: AlertStyle(
              titleStyle: const TextStyle(fontWeight: FontWeight.bold),
              descStyle: const TextStyle(fontSize: 14),
              overlayColor: Colors.black.withOpacity(0.6),
              animationType: AnimationType.fromTop,
              alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide.none),
            ),
            buttons: [
              DialogButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
                },
                width: 120,
                color: Colors.green,
                child: const Text("بله", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              DialogButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                width: 120,
                color: Colors.red[400],
                child: const Text("خیر", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
            closeIcon: const Icon(Icons.close, color: Colors.red))
        .show();
  }
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
        ListTile(
          leading: const Icon(Icons.exit_to_app, color: Colors.red),
          title: const Text(
            'خروج از حساب کاربری',
          ),
          onTap: () => _showAlert(context),
        ),
      ]),
    );
  }
}
