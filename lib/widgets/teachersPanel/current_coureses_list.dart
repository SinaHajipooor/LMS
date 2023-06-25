import 'package:flutter/material.dart';
import 'package:lms/widgets/course/course_item.dart';

class CurrentCoursesList extends StatelessWidget {
  // ---------------- feilds ------------------
  final List<dynamic> teacherCurrentCourses;
  const CurrentCoursesList({super.key, required this.teacherCurrentCourses});
  // ---------------- feilds ------------------
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teacherCurrentCourses.length,
      itemBuilder: (ctx, i) => CourseItem(
        courseId: teacherCurrentCourses[i]['id'],
        eduId: teacherCurrentCourses[i]['edu_id'],
        courseTitle: teacherCurrentCourses[i]['title'],
        coursePrice: teacherCurrentCourses[i]['final_amount'],
        courseTime: teacherCurrentCourses[i]['time'],
        courseImage: teacherCurrentCourses[i]['main_image'],
        teacherAvatar: teacherCurrentCourses[i]['teacher']['avatar'],
        teacherName: teacherCurrentCourses[i]['teacher']['name'],
        courseSessions: teacherCurrentCourses[i]['sessions'],
      ),
    );
  }
}
