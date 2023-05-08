import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../../screens/course/course_resources_screen.dart';

class CourseResourcesCard extends StatelessWidget {
  // ------------------ feilds -------------------
  final List seasons;
  final int courseId;
  const CourseResourcesCard({super.key, required this.seasons, required this.courseId});
  // ------------------ UI -------------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseResourcesScreen(
              resources: seasons,
              courseId: courseId,
            ),
          ),
        );
      },
      child: Container(
        width: deviceSize.width / 2,
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('منابع آموزشی', style: TextStyle(fontSize: 13)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseResourcesScreen(
                            resources: seasons,
                            courseId: courseId,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.video_call_outlined, color: Colors.blue)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
