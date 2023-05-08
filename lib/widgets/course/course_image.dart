import 'package:flutter/material.dart';

class CourseImage extends StatelessWidget {
  final String imageUrl;
  const CourseImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      child: Image.network(
        imageUrl,
        height: deviceSize.height / 2.8,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
