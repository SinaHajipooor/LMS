import 'package:flutter/material.dart';
import '../../../screens/course/electronic_course_detail_screen.dart';

class ElectronicCourseItem extends StatelessWidget {
  //---------------- feilds -----------------
  final int courseId;
  final int eduId;
  final String courseTitle;
  final String coursePrice;
  final String courseTime;
  final String courseImage;
  final String teacherAvatar;
  final String teacherName;
  final int courseSessions;
  const ElectronicCourseItem({
    super.key,
    required this.courseId,
    required this.eduId,
    required this.courseTitle,
    required this.coursePrice,
    required this.courseTime,
    required this.courseImage,
    required this.teacherAvatar,
    required this.teacherName,
    required this.courseSessions,
  });
  //---------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ElectronicCourseDetailScreen.routeName, arguments: courseId);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 120,
        width: deviceSize.width - 20,
        child: Card(
          elevation: 0.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: [
                SizedBox(
                  width: 130,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 600),
                      tween: Tween<double>(begin: 0, end: 1),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: child,
                        );
                      },
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.png',
                        image: courseImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, right: 7),
                        child: Text(courseTitle, style: const TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 7),
                        child: Text('استاد دوره : $teacherName', style: const TextStyle(fontSize: 11)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 7),
                        child: Text('قیمت : $coursePrice تومان', style: const TextStyle(fontSize: 11)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 7),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.watch_later_outlined, size: 15),
                                      const SizedBox(width: 4),
                                      Text('$courseTime ساعت', style: const TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.video_collection_outlined, size: 14),
                                      const SizedBox(width: 4),
                                      Text('$courseSessions قسمت', style: const TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Icon(Icons.bookmark_border, size: 17),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
