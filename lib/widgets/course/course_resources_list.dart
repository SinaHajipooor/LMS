import 'package:flutter/material.dart';
import 'package:lms/widgets/course/course_season_card.dart';

class CourseResourcesList extends StatelessWidget {
  final List resources;
  final int courseId;
  const CourseResourcesList({super.key, required this.resources, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 50),
      height: deviceSize.height * 0.5,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: resources.length,
        itemBuilder: (ctx, i) => Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CourseSeasonCard(
            title: resources[i]['title'],
            sessions: resources[i]['sessions'],
          ),
        ),
      ),
    );
  }
}
