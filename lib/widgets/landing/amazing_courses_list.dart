import 'package:flutter/material.dart';
import 'package:lms/data/data.dart';
import 'package:lms/widgets/landing/amazing_course_item.dart';

class AmazingCoursesList extends StatelessWidget {
  const AmazingCoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    final amazingCourses = AppDatabase.posts;
    return Column(
      children: [
        Visibility(
          visible: amazingCourses.isNotEmpty,
          child: ListView.builder(
            itemExtent: 141,
            shrinkWrap: true,
            itemCount: amazingCourses.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              final amazingCourse = amazingCourses[index];
              return AmazingCourseItem(amazingCourse: amazingCourse);
            },
          ),
        ),
        Visibility(
          visible: amazingCourses.isEmpty,
          child: SizedBox(
            height: 150,
            child: Center(
              child: Text('دوره‌ای وجود ندارد !', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal)),
            ),
          ),
        )
      ],
    );
  }
}
