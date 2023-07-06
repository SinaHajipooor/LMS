import 'package:flutter/material.dart';
import 'package:lms/data/data.dart';

class TeacherItem extends StatelessWidget {
  final StoryData teacher;
  const TeacherItem({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 12, 4, 0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                width: 70,
                height: 70,
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
                    child: Image.asset('assets/images/avatar.png'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            teacher.name,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
