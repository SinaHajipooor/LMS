import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms/screens/teacher/teacher_dashbor_screen.dart';
import 'package:lms/screens/teacher/teaching_document_screen.dart';

class TeacherBottomTabs extends StatefulWidget {
  final int defaultPageIndex;
  const TeacherBottomTabs({super.key, required this.defaultPageIndex});
  @override
  State createState() => _TeacherBottomTabsState();
}

class _TeacherBottomTabsState extends State<TeacherBottomTabs> {
  // ----------------- state ------------------
  int? _currentIndex;
  final List<Widget> _screens = [
    TeacherDashbordScreen(),
    TeachingDocumentScreen(),
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
                width: MediaQuery.of(context).size.width / 1.5,
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
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: displayWidth * .01),
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
                            width: displayWidth * .3,
                            alignment: Alignment.center,
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              height: index == _currentIndex ? displayWidth * .13 : 0,
                              width: displayWidth * .32,
                              decoration: BoxDecoration(
                                color: index == _currentIndex ? Colors.orange.withOpacity(.2) : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: displayWidth * .02),
                                Icon(
                                  listOfIcons[index],
                                  size: displayWidth * .055,
                                  color: index == _currentIndex ? Colors.orange : Colors.black26,
                                ),
                                SizedBox(width: displayWidth * .01),
                                AnimatedOpacity(
                                  opacity: 1,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Text(
                                    listOfStrings[index],
                                    style: TextStyle(
                                      color: index == _currentIndex ? Colors.orange : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
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
    Icons.home,
    Icons.edit_document,
  ];

  List listOfStrings = ['داشبود', 'پرونده تدریس'];
}
