import 'package:flutter/material.dart';
import '../../widgets/exam/exam_header.dart';
import '../../widgets/exam/questions_list.dart';
import '../../widgets/exam/answers_list.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './exam_result_screen.dart';

class ExamScreen extends StatefulWidget {
  // ------------------- feilds -------------------
  static const routeName = '/exam-screen';

  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
// ----------------- state -------------------
  final PageController _pageController = PageController();
  int? examId;
  int _selectedAnswerId = -1;
  int? courseId;
  int selectedQuestionIndex = 0;

  List<String> _questions = [
    "Question 1: What is Flutter?",
    "Question 1: What is Flutter?",
    "Question 1: What is Flutter?",
    "Question 1: What is Flutter?",
    "Question 1: What is Flutter?",
    "Question 1: What is Flutter?",
    "Question 1: What is Flutter?" "Question 2: What is Dart?, Question 1: What is Flutter?" "Question 2: What is Dart?Question 1: What is Flutter?" "Question 2: What dfgdngdf gjdfhgjdhfgdhjghgd hgjdfhg dfgjhfdjg dfj gfdjghd fghdf gjhdfhjfdhgdfjgdhfjgdfhg ghjdfhg dfjhgjdf ghjdf gjhdfjhfdg jhgdjf ityryryryryryryryrytrryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyys Dart?",
    "Question 3: What is a widget?",
    "Question 4: What is hot reload?",
  ];

  List<List<String>> _answers = [
    ["A) A new programming language", "B) A mobile development framework", "C) An IDE for Android Studio", "D) None of the above"],
    ["A) A new programming language", "B) A mobile development framework", "C) An IDE for Android Studio", "D) None of the above"],
    ["A) A visual element in a user interface", "B) A type of data structure", "C) A function in Dart", "D) A database query language"],
    ["A) The process of compiling Dart code", "B) The process of reloading the app on the emulator or device", "C) A feature only available on iOS", "D) None of the above"]
  ];

// ----------------- lifecycle -----------------
  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      examId = arguments['examId'];
      courseId = arguments['courseId'];
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

// ----------------- methods -----------------
  void _onChangePage(int index) {
    setState(() {
      selectedQuestionIndex = index;
    });
    _pageController.animateToPage(
      selectedQuestionIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void onSelectAnswer(int value) {
    setState(() {
      _selectedAnswerId = value;
    });
  }

  _showAlert(BuildContext context) {
    Alert(
            context: context,
            type: AlertType.warning,
            title: "پایان آزمون",
            desc: "آیا از اتمام آزمون خود اطمینان دارید ؟",
            style: AlertStyle(
              titleStyle: const TextStyle(fontWeight: FontWeight.bold),
              descStyle: const TextStyle(fontSize: 14),
              overlayColor: Colors.black.withOpacity(0.6),
              animationType: AnimationType.fromTop,
              alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide.none),
            ),
            buttons: [
              DialogButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed(ExamResultScreen.routeName, arguments: courseId),
                width: 120,
                color: Colors.green,
                child: const Text("بله", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              DialogButton(
                onPressed: () => Navigator.of(context).pop(),
                width: 120,
                color: Colors.red[400],
                child: const Text("خیر", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
            closeIcon: const Icon(Icons.close, color: Colors.red))
        .show();
  }

  // ------------------- UI -------------------
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              ExamHeader(finishExam: _showAlert),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QuestionsList(
                          onChangePage: _onChangePage,
                          pageController: _pageController,
                          questions: _questions,
                          selectedQuestionIndex: selectedQuestionIndex,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnswersList(
                                selectedAnswerId: _selectedAnswerId,
                                onSelectAnswer: onSelectAnswer,
                                answers: _answers,
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 50, top: 20),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedAnswerId = -1;
                                    });
                                  },
                                  child: const Text('پاک کردن انتخاب', style: TextStyle(fontSize: 12)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: selectedQuestionIndex != 0,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (selectedQuestionIndex > 0) {
                                      _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                                      setState(() {
                                        selectedQuestionIndex--;
                                      });
                                    }
                                  },
                                  child: const Text('قبلی'),
                                ),
                              ),
                            ),
                            DropdownButton(
                              elevation: 1,
                              icon: const Icon(Icons.arrow_drop_up),
                              menuMaxHeight: 220,
                              value: selectedQuestionIndex,
                              items: List.generate(_questions.length, (index) {
                                return DropdownMenuItem(
                                  value: index,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('سوال ${index + 1}', style: const TextStyle(fontSize: 14)),
                                  ),
                                );
                              }),
                              onChanged: (value) {
                                setState(() {
                                  selectedQuestionIndex = value!;
                                });
                                _pageController.animateToPage(
                                  selectedQuestionIndex,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                onPressed: selectedQuestionIndex == _questions.length - 1
                                    ? () => _showAlert(context)
                                    : () {
                                        if (selectedQuestionIndex < _questions.length - 1) {
                                          _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                                          setState(() {
                                            selectedQuestionIndex++;
                                          });
                                        }
                                      },
                                child: Text(selectedQuestionIndex == _questions.length - 1 ? 'پایان' : 'بعدی'),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
