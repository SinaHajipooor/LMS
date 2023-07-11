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
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ElectronicCourseDetailScreen.routeName, arguments: courseId);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        height: 130,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                SizedBox(
                  width: 130,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
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
                        child: Text(courseTitle, style: theme.textTheme.titleSmall!.apply(color: Colors.blue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 7),
                        child: Text('استاد دوره : $teacherName', style: theme.textTheme.bodyMedium),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 7),
                        child: Text('قیمت : $coursePrice تومان', style: theme.textTheme.bodyMedium),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 7, bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later_outlined, size: 15, color: Colors.grey[600]),
                                      const SizedBox(width: 4),
                                      Text('$courseTime ساعت', style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.video_collection_outlined, size: 15, color: Colors.grey[600]),
                                      const SizedBox(width: 4),
                                      Text('$courseSessions جلسه', style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                  const SizedBox(),
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
