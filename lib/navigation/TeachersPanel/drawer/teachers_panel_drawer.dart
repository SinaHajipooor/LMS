import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/helpers/theme/theme_helper.dart';
import 'package:lms/navigation/StudentsPanel/bottomTab/students_bottom_tabas.dart';
import 'package:lms/providers/Auth/AuthProvider.dart';
import 'package:lms/screens/root/landing_screen.dart';
import 'package:lms/screens/profile/user/user_profile_screen.dart';
import 'package:provider/provider.dart';

class TeachersPanelDrawer extends StatefulWidget {
  const TeachersPanelDrawer({super.key});

  @override
  State<TeachersPanelDrawer> createState() => _TeachersPanelDrawerState();
}

class _TeachersPanelDrawerState extends State<TeachersPanelDrawer> {
  void _showConfirmationAlert(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      dialogBackgroundColor: Theme.of(context).dialogBackgroundColor,
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
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;

    return Drawer(
      backgroundColor: themeMode == ThemeMode.dark ? theme.cardTheme.color : Colors.white,
      child: ListView(
        children: <Widget>[
          Stack(
            children: [
              UserAccountsDrawerHeader(
                onDetailsPressed: () => Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName),
                decoration: BoxDecoration(color: themeMode == ThemeMode.dark ? Color.fromARGB(255, 41, 46, 54) : Colors.orange[300]),
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
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  child: InkWell(
                    key: ValueKey(themeMode),
                    onTap: () {
                      Provider.of<MyThemeModel>(context, listen: false).toggleTheme();
                    },
                    child: Image.asset(
                      themeMode == ThemeMode.light ? 'assets/images/icons/night.png' : 'assets/images/icons/sun.png',
                      color: Colors.white,
                      width: 30,
                      height: 30,
                    ),
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
              leading: Image.asset('assets/images/icons/home.png', width: 18, height: 18, color: themeMode == ThemeMode.dark ? Colors.white : const Color.fromARGB(255, 92, 92, 92)),
              title: Text('صفحه‌اصلی', style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14)),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName);
            },
            child: ListTile(
              leading: Image.asset('assets/images/icons/person.png', width: 18, height: 18, color: themeMode == ThemeMode.dark ? Colors.white : const Color.fromARGB(255, 92, 92, 92)),
              title: Text('پروفایل', style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14)),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const StudentsBottomTabs(defaultPageIndex: 2)));
            },
            child: ListTile(
              leading: Image.asset('assets/images/icons/student.png', width: 18, height: 18, color: themeMode == ThemeMode.dark ? Colors.white : const Color.fromARGB(255, 92, 92, 92)),
              title: Text('پنل فراگیران', style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14)),
            ),
          ),

          InkWell(
            onTap: () {
              _showConfirmationAlert(context);
            },
            child: ListTile(
              leading: Image.asset('assets/images/icons/exit.png', width: 19, height: 19, color: themeMode == ThemeMode.dark ? Colors.white : const Color.fromARGB(255, 92, 92, 92)),
              title: Text('خروج', style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14)),
            ),
          ),
          // Add more ListTile items as needed
        ],
      ),
    );
  }
}
