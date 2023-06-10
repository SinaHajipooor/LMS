import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/providers/Auth/AuthProvider.dart';
import 'package:provider/provider.dart';
import '../screens/landing_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
            title: Text(_selectedPage == 1 ? 'پنل فراگیران' : 'پنل مدرسان', style: const TextStyle(color: Colors.black, fontSize: 16)),
            automaticallyImplyLeading: false,
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
            },
            child: const ListTile(
              leading: Icon(Icons.home_outlined, color: Colors.blue),
              title: Text('صفحه‌اصلی'),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedPage = 2;
              });
            },
            child: Container(
              color: _selectedPage == 2 ? Colors.grey[200] : null,
              child: const ListTile(
                leading: Icon(Icons.person, color: Colors.blue),
                title: Text('پنل مدرسان'),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _showConfirmationAlert(context);
            },
            child: const ListTile(
              leading: Icon(Icons.logout, size: 20, color: Colors.red),
              title: Text('خروج', style: TextStyle(fontSize: 14)),
            ),
          ),
        ]),
      ),
    );
  }
}
