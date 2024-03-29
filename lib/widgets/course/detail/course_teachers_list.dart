import 'package:flutter/material.dart';

class CourseTeachersList extends StatelessWidget {
  const CourseTeachersList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                2,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'http://45.149.77.156:8080/portal-assets/img/team/team-1.jpg',
                          width: 40,
                          height: 44,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('سیناحاجی‌پور', style: theme.textTheme.bodyMedium!.copyWith(fontSize: 11), overflow: TextOverflow.ellipsis, maxLines: 2),
                            Text('مدرس', style: theme.textTheme.bodySmall!.copyWith(fontSize: 10)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
