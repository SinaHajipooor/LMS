import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/navigation/StudentsPanel/students_bottom_tabas.dart';
import 'package:lms/providers/Auth/AuthProvider.dart';
import 'package:lms/screens/root/landing_screen.dart';
import 'package:lms/screens/profile/user_birth_certificate_form.dart';
import 'package:lms/screens/profile/user_education_screen.dart';
import 'package:lms/screens/profile/user_job_info_screen.dart';
import 'package:provider/provider.dart';

class UserInfoList extends StatefulWidget {
  const UserInfoList({super.key});

  @override
  State<UserInfoList> createState() => _UserInfoListState();
}

class _UserInfoListState extends State<UserInfoList> {
  //----------------- state --------------------

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
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Provider.of<AuthProvider>(context, listen: false).logout();
        Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
      },
    ).show();
  }

  //----------------- UI --------------------

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final themeMode = Provider.of<ThemeModel>(context).themeMode;
    return Padding(
      padding: EdgeInsets.only(top: deviceSize.height / 2.5),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: themeMode == ThemeMode.dark ? const Color.fromARGB(255, 30, 33, 37) : Colors.blue,
              child: const Image(
                width: 20,
                height: 20,
                image: AssetImage('assets/images/icons/dashboard.png'),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const StudentsBottomTabs(defaultPageIndex: 2),
                ),
              );
            },
            title: Text(
              'داشبورد',
              style: theme.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: themeMode == ThemeMode.dark ? const Color.fromARGB(255, 30, 33, 37) : Colors.blue,
              child: const Image(
                width: 24,
                height: 24,
                image: AssetImage('assets/images/icons/person.png'),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(UserBirthCertificateScreen.routeName);
            },
            title: Text(
              'اطلاعات شناسنامه‌ای',
              style: theme.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: themeMode == ThemeMode.dark ? const Color.fromARGB(255, 30, 33, 37) : Colors.blue,
              child: const Image(
                width: 22,
                height: 22,
                image: AssetImage('assets/images/icons/university.png'),
              ),
            ),
            onTap: () => Navigator.of(context).pushNamed(UserEducationScreen.routeName),
            title: Text(
              'اطلاعات تحصیلی',
              style: theme.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: themeMode == ThemeMode.dark ? const Color.fromARGB(255, 30, 33, 37) : Colors.blue,
              child: const Image(
                width: 25,
                height: 25,
                image: AssetImage('assets/images/icons/job.png'),
              ),
            ),
            onTap: () => Navigator.of(context).pushNamed(UserJobInfoScreen.routeName),
            title: Text(
              'اطلاعات شغلی',
              style: theme.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: themeMode == ThemeMode.dark ? const Color.fromARGB(255, 30, 33, 37) : Colors.blue,
              child: const Image(
                width: 20,
                height: 20,
                image: AssetImage('assets/images/icons/exit.png'),
              ),
            ),
            onTap: () => _showConfirmationAlert(context),
            title: Text(
              'خروج',
              style: theme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
