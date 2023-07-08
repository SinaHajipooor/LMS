import 'package:flutter/material.dart';

class CourseAssessmentAnswer extends StatelessWidget {
  final int answerId;
  final int questionId;
  final String answerText;
  final Map<int, int> selectedAnswers;
  final Function(int, int) onSelectAnswer;

  const CourseAssessmentAnswer({
    Key? key,
    required this.answerId,
    required this.questionId,
    required this.answerText,
    required this.selectedAnswers,
    required this.onSelectAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () => onSelectAnswer(questionId, answerId),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              value: answerId,
              groupValue: selectedAnswers[questionId],
              onChanged: (value) => onSelectAnswer(questionId, value!),
            ),
            Text(answerText, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
