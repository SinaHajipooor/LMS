import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms/screens/course/electronic_courses_screen.dart';
import 'package:lms/screens/course/simple_courses_screen.dart';
import 'package:lms/screens/dashbord_screen.dart';
import 'package:lms/screens/profile/profile_screen.dart';

class BottomTabs extends StatefulWidget {
  final int defaultPageIndex;
  BottomTabs({required this.defaultPageIndex});
  @override
  State createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  // ----------------- state ------------------
  int? _currentIndex;
  final List<Widget> _screens = [
    const ElectronicCoursesScreen(),
    const SimpleCoursesScreen(),
    DashbordScreen(),
    const ProfileScreen(),
  ];
  // ----------------- lifecycle ------------------
  // @override
  // void didChangeDependencies() {
  //   _currentIndex = widget.defaultPageIndex;
  //   super.didChangeDependencies();
  // }
  @override
  void initState() {
    _currentIndex = widget.defaultPageIndex;
    super.initState();
  }
  // ----------------- UI ------------------

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _screens[_currentIndex!],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 15),
              child: SizedBox(
                height: displayWidth * .155,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                          HapticFeedback.lightImpact();
                        });
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == _currentIndex ? displayWidth * .32 : displayWidth * .18,
                            alignment: Alignment.center,
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              height: index == _currentIndex ? displayWidth * .12 : 0,
                              width: index == _currentIndex ? displayWidth * .32 : 0,
                              decoration: BoxDecoration(
                                color: index == _currentIndex ? Colors.blueAccent.withOpacity(.2) : Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == _currentIndex ? displayWidth * .31 : displayWidth * .18,
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      width: index == _currentIndex ? displayWidth * .13 : 0,
                                    ),
                                    AnimatedOpacity(
                                      opacity: index == _currentIndex ? 1 : 0,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: Text(
                                        index == _currentIndex ? listOfStrings[index] : '',
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      width: index == _currentIndex ? displayWidth * .03 : 20,
                                    ),
                                    Icon(
                                      listOfIcons[index],
                                      size: displayWidth * .076,
                                      color: index == _currentIndex ? Colors.blueAccent : Colors.black26,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List listOfIcons = [
    Icons.computer,
    Icons.people_alt,
    Icons.home,
    Icons.person_rounded,
  ];

  List listOfStrings = [
    'الکترونیک',
    'حضوری',
    'داشبورد',
    'پروفایل',
  ];
}
