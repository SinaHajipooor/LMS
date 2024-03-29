import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms/helpers/theme/theme_helper.dart';
import 'package:lms/screens/course/electronic/electronic_courses_screen.dart';
import 'package:lms/screens/course/simple/simple_courses_screen.dart';
import 'package:lms/screens/students/students_dashbord_screen.dart';
import 'package:lms/screens/students/educational_document_screen.dart';
import 'package:provider/provider.dart';

class StudentsBottomTabs extends StatefulWidget {
  final int defaultPageIndex;
  const StudentsBottomTabs({super.key, required this.defaultPageIndex});
  @override
  State createState() => _StudentsBottomTabsState();
}

class _StudentsBottomTabsState extends State<StudentsBottomTabs> {
  // ----------------- state ------------------
  int? _currentIndex;
  final List<Widget> _screens = [
    const ElectronicCoursesScreen(),
    const SimpleCoursesScreen(),
    StudentsDashbordScreen(),
    const EducationalDocumentScreen(),
  ];
  // ----------------- lifecycle ------------------

  @override
  void initState() {
    _currentIndex = widget.defaultPageIndex;
    super.initState();
  }
  // ----------------- UI ------------------

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _screens[_currentIndex!],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 15),
              child: SizedBox(
                height: displayWidth * .155,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: themeMode == ThemeMode.dark ? const Color.fromARGB(255, 35, 40, 49) : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: themeMode == ThemeMode.light ? Colors.black.withOpacity(.1) : Colors.blue.withOpacity(.0),
                        blurRadius: 5,
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
                            width: index == _currentIndex ? displayWidth * .32 : displayWidth * .18,
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      width: index == _currentIndex ? displayWidth * .10 : 0,
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
                                          fontSize: 13,
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
                                    Image(
                                      width: 22,
                                      height: 22,
                                      color: index == _currentIndex ? Colors.blueAccent : Colors.grey,
                                      image: listofImageIcons[index],
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

  List listofImageIcons = [
    const AssetImage('assets/images/icons/computer.png'),
    const AssetImage('assets/images/icons/non-university-teacher.png'),
    const AssetImage('assets/images/icons/dashboard.png'),
    const AssetImage('assets/images/icons/book.png'),
  ];

  List listOfStrings = [
    'الکترونیک',
    'کوتاه‌مدت',
    'داشبورد',
    'آموزشی',
  ];
}
