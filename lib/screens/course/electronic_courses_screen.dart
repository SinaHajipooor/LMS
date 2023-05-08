import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/course/courses_list.dart';
import '../../providers/Course/CourseProvider.dart';
import '../../widgets/elements/spinner.dart';

enum FilterOptions { List, Item }

class ElectronicCoursesScreen extends StatefulWidget {
// --------------- feilds -----------------
  static const routeName = '/electronic-courses-screen';

  const ElectronicCoursesScreen({super.key});

  @override
  State<ElectronicCoursesScreen> createState() => _ElectronicCoursesScreenState();
}

class _ElectronicCoursesScreenState extends State<ElectronicCoursesScreen> {
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
            ? Center(child: Spinner(size: 40))
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
    );
  }
}
