import 'package:flutter/material.dart';
import 'package:lms/providers/Course/SimpleCourseProvider.dart';
import 'package:lms/widgets/course/simple/simple_course_item.dart';
import 'package:provider/provider.dart';

class SimpleCoursesList extends StatefulWidget {
  // -------------- feilds ----------------

  final int groupId;
  const SimpleCoursesList({super.key, required this.groupId});

  @override
  State<SimpleCoursesList> createState() => _SimpleCoursesListState();
}

class _SimpleCoursesListState extends State<SimpleCoursesList> {
//------------------ state -------------------
  List<dynamic> electronicCourses = [];
  List<dynamic> simpleCourses = [];
//------------------ lifecycle -------------------

  @override
  void initState() {
    fetchSimpleCourseById();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//------------------ methods -------------------
  Future<void> fetchSimpleCourseById() async {
    electronicCourses = await Provider.of<SimpleCourseProvider>(context, listen: false).fetchSimpleCoursesByGroupId(widget.groupId);
    if (mounted) {
      setState(() {});
    }
  }

//------------------ UI -------------------
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: electronicCourses.length,
      itemBuilder: (ctx, i) => SimpleCourseItem(
        courseId: electronicCourses[i]['id'],
        eduId: electronicCourses[i]['edu_id'],
        courseTitle: electronicCourses[i]['title'],
        coursePrice: electronicCourses[i]['final_amount'],
        courseTime: electronicCourses[i]['time'],
        courseImage: electronicCourses[i]['main_image'],
        teacherAvatar: electronicCourses[i]['teacher']['avatar'],
        teacherName: electronicCourses[i]['teacher']['name'],
        meetings: electronicCourses[i]['meetings'],
      ),
    );
  }
}
