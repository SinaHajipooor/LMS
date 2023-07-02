import 'package:flutter/material.dart';
import 'package:lms/navigation/bottom_tabas.dart';
import 'package:lms/widgets/profile/user_birth_certificate_form.dart';

class UserInfoList extends StatelessWidget {
  const UserInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: deviceSize.height / 2.5),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListTile(
            leading: const CircleAvatar(
              child: Image(
                width: 20,
                height: 20,
                image: AssetImage('assets/images/icons/dashboard.png'),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const BottomTabs(defaultPageIndex: 2),
                ),
              );
            },
            title: const Text(
              'داشبورد',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const CircleAvatar(
              child: Image(
                width: 24,
                height: 24,
                image: AssetImage('assets/images/icons/person.png'),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(UserBirthCertificateScreen.routeName);
            },
            title: const Text(
              'اطلاعات شناسنامه‌ای',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const CircleAvatar(
              child: Image(
                width: 22,
                height: 22,
                image: AssetImage('assets/images/icons/university.png'),
              ),
            ),
            onTap: () {},
            title: const Text(
              'اطلاعات تحصیلی',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const CircleAvatar(
              child: Image(
                width: 25,
                height: 25,
                image: AssetImage('assets/images/icons/job.png'),
              ),
            ),
            onTap: () {},
            title: const Text(
              'اطلاعات شغلی',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const CircleAvatar(
              child: Image(
                width: 20,
                height: 20,
                image: AssetImage('assets/images/icons/exit.png'),
              ),
            ),
            onTap: () {},
            title: const Text(
              'خروج',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
