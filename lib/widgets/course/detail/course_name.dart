import 'package:flutter/material.dart';

class CourseName extends StatelessWidget {
  final String courseName;
  const CourseName({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
      child: Text(
        courseName,
        style: theme.textTheme.titleLarge,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
