import 'package:flutter/material.dart';
import 'package:lms/data/data.dart';
import 'package:lms/widgets/landing/amazing_course_item.dart';

class AmazingCoursesList extends StatelessWidget {
  const AmazingCoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    final amazingCourses = AppDatabase.posts;
    return Visibility(
      visible: amazingCourses.isNotEmpty,
      replacement: SizedBox(
        height: 150,
        child: Center(
          child: Text('دوره‌ای وجود ندارد !', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal)),
        ),
      ),
      child: ListView.builder(
        itemExtent: 141,
        shrinkWrap: true,
        itemCount: amazingCourses.length <= 3 ? amazingCourses.length : 3,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final amazingCourse = amazingCourses[index];
          return AmazingCourseItem(amazingCourse: amazingCourse);
        },
      ),
    );
  }
}
