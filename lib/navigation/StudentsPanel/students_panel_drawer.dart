import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/navigation/TeachersPanel/teachers_bottom_tabs.dart';
import 'package:lms/providers/Auth/AuthProvider.dart';
import 'package:lms/screens/root/landing_screen.dart';
import 'package:lms/screens/profile/user_profile_screen.dart';
import 'package:provider/provider.dart';

class StudentsPanelDrawer extends StatefulWidget {
  const StudentsPanelDrawer({super.key});

  @override
  State<StudentsPanelDrawer> createState() => _StudentsPanelDrawerState();
}

class _StudentsPanelDrawerState extends State<StudentsPanelDrawer> {
  void _showConfirmationAlert(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: 'خروج از حساب',
      titleTextStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
      desc: 'آیا مطمعن هستید که از حساب خود خارج می‌شوید ؟',
      descTextStyle: const TextStyle(fontSize: 13),
      btnCancelColor: Colors.red,
      btnOkColor: const Color.fromARGB(255, 99, 223, 103),
      btnOkText: 'بله',
      buttonsBorderRadius: BorderRadius.circular(9),
      btnCancelText: 'لغو',
      buttonsTextStyle: const TextStyle(fontSize: 15),
      btnCancelOnPress: () => Navigator.of(context).pop(),
      btnOkOnPress: () {
        Provider.of<AuthProvider>(context, listen: false).logout();
        Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            onDetailsPressed: () => Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName),
            decoration: const BoxDecoration(color: Colors.lightBlue),
            accountName: const Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                "سیناحاجی پور",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            accountEmail: const Padding(
              padding: EdgeInsets.zero,
              child: Text(
                "+98 9155613393",
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 12),
              ),
            ),
            currentAccountPicture: InkWell(
              onTap: () => Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName),
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
            },
            child: ListTile(
              leading: Image.asset('assets/images/icons/home.png', width: 20, height: 20, color: const Color.fromARGB(255, 92, 92, 92)),
              title: const Text('صفحه‌اصلی', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName);
            },
            child: ListTile(
              leading: Image.asset('assets/images/icons/person.png', width: 20, height: 20, color: const Color.fromARGB(255, 92, 92, 92)),
              title: const Text('پروفایل', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const TeachersBottomTabs(defaultPageIndex: 0)));
            },
            child: ListTile(
              leading: Image.asset('assets/images/icons/teacher.png', width: 20, height: 20, color: const Color.fromARGB(255, 92, 92, 92)),
              title: const Text('پنل مدرسان', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ),

          InkWell(
            onTap: () {
              _showConfirmationAlert(context);
            },
            child: ListTile(
              leading: Image.asset('assets/images/icons/exit.png', width: 20, height: 20, color: const Color.fromARGB(255, 92, 92, 92)),
              title: const Text('خروج', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ),
          // Add more ListTile items as needed
        ],
      ),
    );
  }
}
