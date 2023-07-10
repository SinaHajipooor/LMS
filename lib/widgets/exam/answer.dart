import 'package:flutter/material.dart';
import 'package:lms/widgets/exam/image_preview.dart';

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
            onChanged: (value) {
              onSelect(value);
              print(value);
            },
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  answerText,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
                const SizedBox(width: 15),
                const ImagePreview(imagePath: 'http://45.149.77.156:8080/portal-assets/img/team/team-1.jpg')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
