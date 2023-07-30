import 'package:flutter/material.dart';
import 'package:lms/helpers/internet_connectivity_helper.dart';
import 'package:lms/helpers/theme_helper.dart';
import 'package:lms/screens/auth/phone_number_login.dart';
import 'package:lms/screens/auth/user_pass_login.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // 0 for login and 1 for sign up screen
  int currentTab = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    super.initState();
  }

  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 25, top: 0),
              child: Image.asset(
                'assets/images/avatar-edu.png',
                width: 130,
                height: 130,
                color: themeMode == ThemeMode.dark ? Colors.white : Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  color: themeData.colorScheme.primary,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                currentTab = 0;
                              });
                            },
                            child: Text('نام کاربری و رمزعبور', style: TextStyle(color: currentTab == 0 ? Colors.white : Colors.white54, fontSize: currentTab == 0 ? 15 : 13)),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                currentTab = 1;
                              });
                            },
                            child: Text(
                              'شماره موبایل'.toUpperCase(),
                              style: TextStyle(color: currentTab == 1 ? Colors.white : Colors.white54, fontSize: currentTab == 1 ? 15 : 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeData.scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: currentTab == 0 ? const UserPassLogin() : const PhoneNumberLogin(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
