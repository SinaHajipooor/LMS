import 'package:flutter/material.dart';
import './question.dart';

// ignore: must_be_immutable
class QuestionsList extends StatelessWidget {
  // -------------- fields ------------

  Function onChangePage;
  PageController pageController;
  List<String> questions;
  int selectedQuestionIndex;
  QuestionsList({
    super.key,
    required this.onChangePage,
    required this.pageController,
    required this.questions,
    required this.selectedQuestionIndex,
  });

  // ----------------- UI -------------------
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        itemCount: questions.length,
        controller: pageController,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(top: 30, right: 6),
            child: Question(
              index: index + 1,
              text: questions[index],
            ),
          );
        },
        onPageChanged: (value) => onChangePage,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
