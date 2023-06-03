import 'package:flutter/material.dart';
import 'package:lms/screens/landing_screen.dart';
import 'package:provider/provider.dart';
import '../../widgets/course/courses_list.dart';
import '../../widgets/elements/spinner.dart';
import '../../providers/Course/SimpleCourseProvider.dart';

class SimpleCoursesScreen extends StatefulWidget {
  static const routeName = '/simple-courses-screen';
  const SimpleCoursesScreen({super.key});

  @override
  State<SimpleCoursesScreen> createState() => _SimpleCoursesScreenState();
}

class _SimpleCoursesScreenState extends State<SimpleCoursesScreen> {
  // --------------- state --------------
  var _showItems = false;
  var _isLoading = true;
  var _bottomPadding = 0.0;
  List<dynamic> _courseGroups = [];
// --------------- lifecycle -----------------
  @override
  void initState() {
    // getAllSimpleCourses();
    getAllCourseGroups();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

// --------------- methods -----------------
  // Future<void> getAllSimpleCourses() async {
  //   await Provider.of<CourseProvider>(context, listen: false).fetchAllCourses();
  //   if (mounted) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  Future<void> getAllCourseGroups() async {
    await Provider.of<SimpleCourseProvider>(context, listen: false).fetchSimpleCourseGroups();
    if (mounted) {
      setState(() {
        _courseGroups = Provider.of<SimpleCourseProvider>(context, listen: false).courseGroups;
        _isLoading = false;
      });
    }
  }

// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    final margin = MediaQuery.of(context).size.width * .200;
    return DefaultTabController(
      length: _courseGroups.length,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            toolbarHeight: 12,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            leading: null,
            bottom: TabBar(
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontFamily: 'YekanBakh', fontSize: 12),
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'YekanBakh', fontSize: 14),
              isScrollable: true,
              labelColor: Colors.blue,
              labelPadding: const EdgeInsets.symmetric(horizontal: 25),
              tabs: List.generate(
                _courseGroups.length,
                (index) => Tab(
                  text: _courseGroups[index]['name'],
                ),
              ),
            ),
          ),
          body: _isLoading
              ? const Center(child: Spinner(size: 40))
              : TabBarView(
                  children: List.generate(
                    _courseGroups.length,
                    (index) {
                      final group = _courseGroups[index];
                      return NotificationListener<ScrollEndNotification>(
                        onNotification: (notification) {
                          setState(() {
                            // Add bottom margin if user reached end of scrollable area
                            _bottomPadding = notification.metrics.extentAfter == 0.0 ? margin : 0.0;
                          });
                          return true;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: _bottomPadding),
                          child: CoursesList(
                            groupId: group['id'],
                            showItems: _showItems,
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}