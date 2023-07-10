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
      titleTextStyle: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.red),
      desc: 'آیا مطمعن هستید که از حساب خود خارج می‌شوید ؟',
      descTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal),
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
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          Stack(
            children: [
              UserAccountsDrawerHeader(
                onDetailsPressed: () => Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName),
                decoration: const BoxDecoration(color: Colors.lightBlue),
                accountName: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "سیناحاجی پور",
                    style: theme.textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ),
                accountEmail: Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    "+98 9155613393",
                    textDirection: TextDirection.ltr,
                    style: theme.textTheme.bodyMedium!.apply(color: Colors.white),
                  ),
                ),
                currentAccountPicture: InkWell(
                  onTap: () => Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/avatar.png"),
                  ),
                ),
              ),
              Positioned(
                top: 16.0,
                left: 12.0,
                child: InkWell(
                  child: Image.asset(
                    'assets/images/icons/night.png',
                    color: Colors.white,
                    width: 35,
                    height: 35,
                  ),
                ),
              ),
            ],
          ),

          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
            },
            child: ListTile(
              leading: Image.asset('assets/images/icons/home.png', width: 20, height: 20, color: const Color.fromARGB(255, 92, 92, 92)),
              title: Text('صفحه‌اصلی', style: theme.textTheme.titleSmall),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName);
            },
            child: ListTile(
              leading: Image.asset('assets/images/icons/person.png', width: 20, height: 20, color: const Color.fromARGB(255, 92, 92, 92)),
              title: Text('پروفایل', style: theme.textTheme.titleSmall),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const TeachersBottomTabs(defaultPageIndex: 0)));
            },
            child: ListTile(
              leading: Image.asset('assets/images/icons/teacher.png', width: 20, height: 20, color: const Color.fromARGB(255, 92, 92, 92)),
              title: Text('پنل مدرسان', style: theme.textTheme.titleSmall),
            ),
          ),

          InkWell(
            onTap: () {
              _showConfirmationAlert(context);
            },
            child: ListTile(
              leading: Image.asset('assets/images/icons/exit.png', width: 20, height: 20, color: const Color.fromARGB(255, 92, 92, 92)),
              title: Text('خروج', style: theme.textTheme.titleSmall),
            ),
          ),
          // Add more ListTile items as needed
        ],
      ),
    );
  }
}
