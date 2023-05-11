import 'package:flutter/material.dart';

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
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.png',
        image: imageUrl,
        height: deviceSize.height / 2.8,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
