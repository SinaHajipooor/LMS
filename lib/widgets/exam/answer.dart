import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  // --------------- feilds ---------------
  final String answerText;
  final int answerId;
  final Function onSelect;
  final int selectedAnswerId;

  const Answer({
    super.key,
    required this.answerText,
    required this.answerId,
    required this.onSelect,
    required this.selectedAnswerId,
  });

  // --------------- UI ---------------

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect(answerId),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Radio<int>(
            value: answerId,
            groupValue: selectedAnswerId,
            activeColor: Colors.blue,
            onChanged: (value) => onSelect,
          ),
          Expanded(
            child: Text(
              answerText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }
}
