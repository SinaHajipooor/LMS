import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/data/data.dart';
import 'package:lms/helpers/theme/theme_helper.dart';
import 'package:provider/provider.dart';

class AmazingCourseItem extends StatelessWidget {
  final PostData amazingCourse;
  const AmazingCourseItem({super.key, required this.amazingCourse});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    return Container(
      height: 149,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: themeMode == ThemeMode.light ? Color(0x1a5285ff) : Colors.black12,
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
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Text(amazingCourse.caption, style: theme.textTheme.bodyLarge!.apply(color: Colors.blue)),
                  const SizedBox(width: 5),
                  Row(
                    children: [
                      Text(
                        'نام استاد : ',
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        'سیناحاجی پور',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
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
