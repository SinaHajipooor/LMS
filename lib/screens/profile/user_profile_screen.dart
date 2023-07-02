import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/navigation/bottom_tabas.dart';
import 'package:lms/widgets/profile/user_info_card.dart';
import 'package:lms/widgets/profile/user_info_list.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile-screen';
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  //------------------- state ---------------------

  //------------------- lifecycle ---------------------

  //------------------- UI ---------------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BottomTabs(defaultPageIndex: 2)));
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(height: deviceSize.height / 4, color: Colors.lightBlue),
                ],
              ),
              Positioned(
                top: 35,
                left: deviceSize.width / 2.5,
                child: const Center(
                    child: Text(
                  'اطلاعات کاربری',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ),
              Positioned(
                top: deviceSize.height / 9,
                left: 20,
                right: 20,
                child: const UserInfoCard(),
              ),
              const UserInfoList(),
            ],
          ),
        ),
      ),
    );
  }
}
