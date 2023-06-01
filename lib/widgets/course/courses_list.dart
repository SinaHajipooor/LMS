import 'package:flutter/material.dart';
import 'package:lms/providers/Course/CourseProvider.dart';
import 'package:provider/provider.dart';
import './course_item.dart';
import './course_list_item.dart';

class CoursesList extends StatefulWidget {
  // -------------- feilds ----------------
  final bool showItems;
  final int groupId;
  CoursesList({super.key, required this.showItems, required this.groupId});

  @override
  State<CoursesList> createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
//------------------ state -------------------
  List<dynamic> electronicCourses = [];
//------------------ lifecycle -------------------

  @override
  void initState() {
    fetchElectronicCourseById();
    super.initState();
  }

//------------------ methods -------------------
  Future<void> fetchElectronicCourseById() async {
    electronicCourses = await Provider.of<CourseProvider>(context, listen: false).fetchElectronicCoursesByGroupId(widget.groupId);
    setState(() {});
  }

//------------------ UI -------------------
  @override
  Widget build(BuildContext context) {
    return widget.showItems
        ? Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.builder(
              itemCount: electronicCourses.length,
              itemBuilder: (context, index) => const CourseListItem(),
            ),
          )
        : ListView.builder(
            itemCount: electronicCourses.length,
            itemBuilder: (ctx, i) => CourseItem(
              courseId: electronicCourses[i]['id'],
              eduId: electronicCourses[i]['edu_id'],
              courseTitle: electronicCourses[i]['title'],
              coursePrice: electronicCourses[i]['final_amount'],
              courseTime: electronicCourses[i]['time'],
              courseImage: electronicCourses[i]['main_image'],
              teacherAvatar: electronicCourses[i]['teacher']['avatar'],
              teacherName: electronicCourses[i]['teacher']['name'],
              courseSessions: electronicCourses[i]['sessions'],
            ),
          );
  }
}
