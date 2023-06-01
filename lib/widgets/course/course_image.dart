import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/spinner.dart';

class CourseImage extends StatelessWidget {
  final String imageUrl;
  const CourseImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: Image.network(
        imageUrl,
        height: deviceSize.height / 2.8,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) => Image.asset(
          'assets/images/placeholder.png',
          height: deviceSize.height / 2.8,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: Spinner(
              size: 25,
            ),
          );
        },
      ),
    );
  }
}
