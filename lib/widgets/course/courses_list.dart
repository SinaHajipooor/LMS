import 'package:flutter/material.dart';
import './course_item.dart';
import './course_list_item.dart';

class CoursesList extends StatelessWidget {
  // -------------- feilds ----------------
  final bool showItems;
  final List<dynamic> electronicCourses;
  CoursesList({super.key, required this.showItems, required this.electronicCourses});
  // -------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return showItems
        ? Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.builder(
              itemCount: 8,
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
