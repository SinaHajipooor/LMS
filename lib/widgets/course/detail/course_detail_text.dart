import 'package:flutter/material.dart';

class CourseDetailText extends StatelessWidget {
  final String description;
  const CourseDetailText({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Visibility(
          visible: description.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            child: Text(
              description,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
        Visibility(
            child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 50),
          child: Text(
            'توضیحی برای این دوره وجود ندارد !',
            style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal, fontSize: 13),
          ),
        ))
      ],
    );
  }
}
