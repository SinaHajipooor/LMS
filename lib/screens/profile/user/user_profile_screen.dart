import 'package:flutter/material.dart';
import 'package:lms/helpers/InternetConnectivityHelper.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/navigation/StudentsPanel/students_bottom_tabas.dart';
import 'package:lms/providers/Profile/Identity/IdentityProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/profile/user/user_info_card.dart';
import 'package:lms/widgets/profile/user/user_info_list.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile-screen';
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  //------------------- state ---------------------
  Map<String, dynamic> userIdentityInfo = {};
  bool _isLoading = true;
  //------------------- lifecycle ---------------------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    fetchAllUserIdentityInfo();
    super.initState();
  }

// --------------- methods -----------------
  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  Future<void> fetchAllUserIdentityInfo() async {
    await Provider.of<IdentityProvider>(context, listen: false).fetchAllIdentityInfo();
    setState(() {
      userIdentityInfo = Provider.of<IdentityProvider>(context, listen: false).identityInfo;
      _isLoading = false;
    });
  }

  //------------------- UI ---------------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const StudentsBottomTabs(defaultPageIndex: 2)));
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: _isLoading
              ? const Center(child: Spinner(size: 35))
              : Stack(
                  children: [
                    Column(
                      children: [
                        Container(height: deviceSize.height / 4, color: themeMode == ThemeMode.light ? Colors.lightBlue : const Color.fromARGB(255, 30, 33, 37)),
                      ],
                    ),
                    Positioned(
                      top: 35,
                      left: deviceSize.width / 2.5,
                      child: Center(
                          child: Text(
                        'اطلاعات کاربری',
                        style: theme.textTheme.titleLarge!.apply(color: Colors.white),
                      )),
                    ),
                    Positioned(
                      top: deviceSize.height / 9,
                      left: 12,
                      right: 12,
                      child: UserInfoCard(
                        userIdentityInfo: userIdentityInfo,
                      ),
                    ),
                    const UserInfoList(),
                  ],
                ),
        ),
      ),
    );
  }
}
