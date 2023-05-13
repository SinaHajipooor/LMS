import 'package:flutter/material.dart';
import './answer.dart';

class AnswersList extends StatelessWidget {
  // -------------- feilds ----------------
  int selectedAnswerId;
  List<List<String>> answers;
  Function onSelectAnswer;
  AnswersList({
    super.key,
    required this.selectedAnswerId,
    required this.answers,
    required this.onSelectAnswer,
  });

  // -------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: answers.length,
        itemBuilder: (BuildContext context, int answerIndex) {
          return Answer(
            answerText: answers[answerIndex][answerIndex],
            answerId: answerIndex,
            onSelect: onSelectAnswer,
            selectedAnswerId: selectedAnswerId,
          );
        },
      ),
    );
  }
}
