import 'package:flutter/material.dart';

class CourseDetailText extends StatelessWidget {
  final String description;
  const CourseDetailText({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      child: Text(
        description,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
