import 'package:flutter/material.dart';
import 'package:lms/data/data.dart';

class TeacherItem extends StatelessWidget {
  final StoryData teacher;
  const TeacherItem({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
              width: 59,
              height: 59,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(begin: Alignment.topLeft, colors: [
                  Color(0xff376AED),
                  Color(0xff49B0E2),
                  Color(0xff9CECFB),
                ]),
              ),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  // child: Image.asset('assets/images/avatar.png'),
                  child: Image.network('http://45.149.77.156:8080/portal-assets/img/team/team-2.jpg'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          teacher.name,
          style: theme.textTheme.bodyMedium,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
