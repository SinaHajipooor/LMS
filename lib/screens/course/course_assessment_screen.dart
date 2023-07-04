import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/exam/question.dart';
import '../../widgets/course/assessment/course_assessment_answer.dart';
import '../../providers/Course/CourseProvider.dart';
import '../../widgets/elements/spinner.dart';
import './electronic_course_detail_screen.dart';

class CourseAssessmentScreen extends StatefulWidget {
  //---------------- feilds -------------------
  static const routeName = '/course-assessment-screen';

  const CourseAssessmentScreen({super.key});

  @override
  State<CourseAssessmentScreen> createState() => _CourseAssessmentScreenState();
}

class _CourseAssessmentScreenState extends State<CourseAssessmentScreen> {
// -------------------- state --------------------
  bool _isLoading = false;
  List _questions = [];
  List _answers = [];
  Map<int, int> _selectedAnswers = {};
  int? courseId;
// ----------------- lifecycle ------------------
  @override
  void didChangeDependencies() {
    setState(() {
      courseId = ModalRoute.of(context)!.settings.arguments as int;
    });
    fetchCourseAssessmentDetails(courseId!);
    super.didChangeDependencies();
  }

// -------------------- methods  --------------------
  void fetchCourseAssessmentDetails(int courseId) async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CourseProvider>(context, listen: false).fetchCourseAssessmentDetails(courseId);
    setState(() {
      _questions = Provider.of<CourseProvider>(context, listen: false).courseAssessmentQuestions;
      _answers = Provider.of<CourseProvider>(context, listen: false).courseAssessmentAnswers;
      _selectedAnswers = Map.fromIterable(_questions, key: (q) => q['id'], value: (_) => 0);
      _isLoading = false;
    });
  }

  void _selecteAnswerHandler(int questionId, int answerId) {
    setState(() {
      _selectedAnswers[questionId] = answerId;
    });
  }

  void _showConfirmationAlert(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: 'اتمام ارزشیابی',
      titleTextStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
      desc: 'همه‌ی پاسخ ها را ثبت می‌کنید ؟',
      descTextStyle: const TextStyle(fontSize: 13),
      btnCancelColor: Colors.red,
      btnOkColor: const Color.fromARGB(255, 99, 223, 103),
      btnOkText: 'بله',
      buttonsBorderRadius: BorderRadius.circular(9),
      btnCancelText: 'لغو',
      buttonsTextStyle: const TextStyle(fontSize: 15),
      btnCancelOnPress: () => Navigator.of(context).pop(),
      btnOkOnPress: () {
        Navigator.of(context).pushReplacementNamed(ElectronicCourseDetailScreen.routeName, arguments: courseId);
      },
    ).show();
  }

// -------------------- UI --------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text('ارزیابی اثربخشی', style: TextStyle(color: Colors.black, fontSize: 18)),
        actions: [IconButton(onPressed: () => _showConfirmationAlert(context), icon: const Icon(Icons.save_alt, color: Colors.green))],
      ),
      body: _isLoading
          ? const Center(child: Spinner(size: 35))
          : ListView.builder(
              itemCount: _questions.length,
              itemBuilder: (ctx, i) {
                String questionText = _questions[i]['name'];
                int questionId = _questions[i]['id'];
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Question(index: i + 1, text: questionText, usecase: 2),
                            ),
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _answers
                                    .map(
                                      (answer) => CourseAssessmentAnswer(
                                        answerId: answer['id'],
                                        questionId: questionId,
                                        answerText: answer['name'],
                                        selectedAnswers: _selectedAnswers,
                                        onSelectAnswer: _selecteAnswerHandler,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
