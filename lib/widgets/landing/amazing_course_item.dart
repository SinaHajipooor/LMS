import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/data/data.dart';

class AmazingCourseItem extends StatelessWidget {
  final PostData amazingCourse;
  const AmazingCourseItem({super.key, required this.amazingCourse});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 149,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            color: Color(0x1a5285ff),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/course.png',
              fit: BoxFit.fitHeight,
              width: 140,
              height: 149,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    amazingCourse.caption,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xff376AED),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    amazingCourse.title,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(CupertinoIcons.hand_thumbsup, size: 16),
                      Text(amazingCourse.likes, style: const TextStyle(fontSize: 13)),
                      const SizedBox(width: 16),
                      const Icon(CupertinoIcons.clock, size: 16),
                      Text(amazingCourse.time, style: const TextStyle(fontSize: 13)),
                      const SizedBox(width: 16),
                      Icon(
                        amazingCourse.isBookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                        size: 16,
                        // color: themeData.textTheme.bodyMedium!.color,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
