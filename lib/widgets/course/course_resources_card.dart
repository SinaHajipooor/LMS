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
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return CourseResourcesScreen(
                resources: seasons,
                courseId: courseId,
              );
            },
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
      },
      child: SizedBox(
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
