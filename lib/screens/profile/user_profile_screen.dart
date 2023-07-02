import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/navigation/bottom_tabas.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  //------------------- state ---------------------
  final _scrollController = ScrollController();
  // ignore: unused_field
  bool _isFabVisible = true;
  //------------------- lifecycle ---------------------
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _isFabVisible = false;
        });
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _isFabVisible = true;
        });
      }
    });
  }

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
                child: SizedBox(
                  height: 200,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  color: Colors.grey,
                                  child: Image.asset('assets/images/avatar.png', fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text('سیناحاجی‌پور', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              const Text('فراگیر', style: TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 20,
                          child: InkWell(
                            child: Image.asset('assets/images/icons/edit.png', width: 20, height: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
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
                      onTap: () {},
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
                      onTap: () {},
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
