import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/navigation/bottom_tabas.dart';
import 'package:lms/providers/Auth/AuthProvider.dart';
import 'package:provider/provider.dart';
import '../screens/landing_screen.dart';

class TeacherPanelDrawer extends StatefulWidget {
  const TeacherPanelDrawer({super.key});

  @override
  State<TeacherPanelDrawer> createState() => _TeacherPanelDrawerState();
}

class _TeacherPanelDrawerState extends State<TeacherPanelDrawer> {
  int _selectedPage = 1;

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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: Column(children: [
          AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            title: const Text('یادگیری الکترونیک', style: TextStyle(color: Colors.black, fontSize: 16)),
            automaticallyImplyLeading: false,
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
            },
            child: const ListTile(
              leading: Icon(Icons.home_outlined, color: Colors.orange),
              title: Text('صفحه‌اصلی'),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BottomTabs(defaultPageIndex: 2)));
              setState(() {
                _selectedPage = 2;
              });
            },
            child: Container(
              color: _selectedPage == 2 ? Colors.grey[200] : null,
              child: const ListTile(
                leading: Icon(Icons.person, color: Colors.orange),
                title: Text('پنل فراگیر'),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _showConfirmationAlert(context);
            },
            child: const ListTile(
              leading: Icon(Icons.logout, size: 20, color: Colors.orange),
              title: Text('خروج', style: TextStyle(fontSize: 14)),
            ),
          ),
        ]),
      ),
    );
  }
}
