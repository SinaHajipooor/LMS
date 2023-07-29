import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/screens/teachers/teacher_dashbord_screen.dart';
import 'package:lms/screens/teachers/teaching_document_screen.dart';
import 'package:provider/provider.dart';

class TeachersBottomTabs extends StatefulWidget {
  final int defaultPageIndex;
  const TeachersBottomTabs({super.key, required this.defaultPageIndex});
  @override
  State createState() => _TeachersBottomTabsState();
}

class _TeachersBottomTabsState extends State<TeachersBottomTabs> {
  // ----------------- state ------------------
  int? _currentIndex;
  final List<Widget> _screens = [
    TeacherDashbordScreen(),
    const TeachingDocumentScreen(),
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 15),
              child: SizedBox(
                height: displayWidth * .155,
                width: MediaQuery.of(context).size.width / 1.6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: themeMode == ThemeMode.light ? Colors.black.withOpacity(.1) : Colors.blue.withOpacity(.1),
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: displayWidth * .01),
                    itemBuilder: (context, index) => Center(
                      child: InkWell(
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
                                width: displayWidth * .38,
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
                                    color: index == _currentIndex ? Colors.orange : (themeMode == ThemeMode.dark ? Colors.grey : Colors.grey),
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
          ),
        ],
      ),
    );
  }

  List listOfStrings = ['داشبود', 'پرونده تدریس'];

  List listOfIcons = [
    Icons.home,
    Icons.edit_document,
  ];
}
