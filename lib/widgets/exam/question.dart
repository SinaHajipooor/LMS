import 'package:flutter/material.dart';
import 'package:lms/widgets/exam/image_preview.dart';

class Question extends StatelessWidget {
  final int index;
  final String text;

  const Question({super.key, required this.index, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, top: 0),
          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          width: 30,
          height: 30,
          child: Center(
            child: Text(
              index.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 10),
              ImagePreview(imagePath: 'http://45.149.77.156:8080/portal-assets/img/team/team-1.jpg'),
            ],
          ),
        ),
      ],
    );
  }
}