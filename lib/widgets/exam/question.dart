import 'package:flutter/material.dart';

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
        Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
      ],
    );
  }
}
