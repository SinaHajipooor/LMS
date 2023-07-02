import 'package:flutter/material.dart';
import 'package:lms/data/data.dart';
import 'package:lms/widgets/landing/amazing_course_item.dart';

class AmazingCoursesList extends StatelessWidget {
  const AmazingCoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    final amazingCourses = AppDatabase.posts;
    return ListView.builder(
      itemExtent: 141,
      shrinkWrap: true,
      itemCount: amazingCourses.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final amazingCourse = amazingCourses[index];
        return AmazingCourseItem(amazingCourse: amazingCourse);
      },
    );
  }
}
