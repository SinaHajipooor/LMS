import 'package:flutter/material.dart';
import 'package:lms/screens/landing_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/Course/CourseProvider.dart';
import '../../widgets/course/courses_list.dart';
import '../../widgets/course/course_item.dart';
import '../../widgets/elements/spinner.dart';

class SimpleCoursesScreen extends StatefulWidget {
  static const routeName = '/simple-courses-screen';
  const SimpleCoursesScreen({super.key});

  @override
  State<SimpleCoursesScreen> createState() => _SimpleCoursesScreenState();
}

class _SimpleCoursesScreenState extends State<SimpleCoursesScreen> {
  // --------------- state --------------
  var _showItems = false;
  var _isLoading = false;
// --------------- lifecycle -----------------
  @override
  void initState() {
    getAllElectronicCourses();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

// --------------- methods -----------------
  Future<void> getAllElectronicCourses() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CourseProvider>(context, listen: false).fetchAllCourses();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
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
            bottom: const TabBar(
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'YekanBakh', fontSize: 12),
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'YekanBakh', fontSize: 14),
              isScrollable: true,
              labelColor: Colors.blue,
              labelPadding: EdgeInsets.symmetric(horizontal: 25),
              tabs: [
                Tab(text: 'فرهنگی'),
                Tab(text: 'ورزشی'),
                Tab(text: 'فنی و مهندسی'),
                Tab(text: 'هنر'),
                Tab(text: 'پزشکی'),
                Tab(text: 'فلسفه و عرفان'),
                Tab(text: 'حقوق'),
                Tab(text: 'حقوق'),
                Tab(text: 'حقوق'),
                Tab(text: 'حقوق'),
              ],
            ),
          ),
          body: _isLoading
              ? const Center(child: Spinner(size: 40))
              : TabBarView(
                  children: [
                    CoursesList(electronicCourses: Provider.of<CourseProvider>(context).courses, showItems: _showItems),
                    CoursesList(electronicCourses: Provider.of<CourseProvider>(context).courses, showItems: _showItems),
                    CoursesList(electronicCourses: Provider.of<CourseProvider>(context).courses, showItems: _showItems),
                    CoursesList(electronicCourses: Provider.of<CourseProvider>(context).courses, showItems: _showItems),
                    CoursesList(electronicCourses: Provider.of<CourseProvider>(context).courses, showItems: _showItems),
                    CoursesList(electronicCourses: Provider.of<CourseProvider>(context).courses, showItems: _showItems),
                    CoursesList(electronicCourses: Provider.of<CourseProvider>(context).courses, showItems: _showItems),
                    CoursesList(electronicCourses: Provider.of<CourseProvider>(context).courses, showItems: _showItems),
                    CoursesList(electronicCourses: Provider.of<CourseProvider>(context).courses, showItems: _showItems),
                    CoursesList(electronicCourses: Provider.of<CourseProvider>(context).courses, showItems: _showItems),
                  ],
                ),
        ),
      ),
    );
  }
}
