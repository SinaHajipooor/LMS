import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../../screens/exam/exam_screen.dart';

class CourseExamsList extends StatefulWidget {
// --------------- feilds ----------------
  final String title;
  final List exams;
  final int courseId;
  const CourseExamsList({super.key, required this.title, required this.exams, required this.courseId});

  @override
  State<CourseExamsList> createState() => _CourseExamsListState();
}

class _CourseExamsListState extends State<CourseExamsList> {
// --------------- state ----------------
  bool _isExpanded = false;
// --------------- methods ----------------

  // _showAlert(BuildContext context, int examId) {
  //   Map<String, dynamic> arguments = {'examId': examId, 'courseId': widget.courseId};
  //   Alert(
  //     context: context,
  //     type: AlertType.warning,
  //     title: "شروع آزمون",
  //     desc: "آیا مطمعن هستید که آزمون را شروع می کنید ؟",
  //     style: AlertStyle(
  //       titleStyle: const TextStyle(fontWeight: FontWeight.bold),
  //       descStyle: const TextStyle(fontSize: 14),
  //       overlayColor: Colors.black.withOpacity(0.6),
  //       animationType: AnimationType.fromTop,
  //       alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide.none),
  //     ),
  //     buttons: [
  //       DialogButton(
  //         onPressed: () => Navigator.of(context).pushReplacementNamed(ExamScreen.routeName, arguments: arguments),
  //         width: 120,
  //         color: Colors.green,
  //         child: const Text("بله", style: TextStyle(color: Colors.white, fontSize: 20)),
  //       ),
  //       DialogButton(
  //         onPressed: () => Navigator.pop(context),
  //         width: 120,
  //         color: Colors.red[400],
  //         child: const Text("خیر", style: TextStyle(color: Colors.white, fontSize: 20)),
  //       ),
  //     ],
  //     closeIcon: const Icon(Icons.close, color: Colors.red),
  //   ).show();
  // }
  void _showConfirmationAlert(BuildContext context, int examId) {
    Map<String, dynamic> arguments = {'examId': examId, 'courseId': widget.courseId};

    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: 'شروع آزمون',
      titleTextStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
      desc: 'آیا مطمعن هستید که آزمون را شروع می کنید ؟',
      descTextStyle: const TextStyle(fontSize: 13),
      btnCancelColor: Colors.red,
      btnOkColor: const Color.fromARGB(255, 99, 223, 103),
      btnOkText: 'بله',
      buttonsBorderRadius: BorderRadius.circular(9),
      btnCancelText: 'لغو',
      buttonsTextStyle: const TextStyle(fontSize: 15),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.of(context).pushReplacementNamed(ExamScreen.routeName, arguments: arguments);
      },
    ).show();
  }

// --------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Card(
        elevation: 0.5,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 680),
          curve: Curves.easeInOut,
          height: _isExpanded ? 200 : 55,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                color: _isExpanded ? Colors.blue : Colors.black,
                                fontSize: _isExpanded ? 16.0 : 15,
                                fontWeight: _isExpanded ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                              child: Icon(_isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_left, size: 25.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 1.0),
                      Expanded(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: _isExpanded ? 1.0 : 0.0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.exams.length,
                            itemBuilder: (ctx, i) => Container(
                              decoration: widget.exams.length == i + 1
                                  ? null
                                  : const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                              child: ListTile(
                                title: Text('${widget.exams[i]['type']['name']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                subtitle: Text('تعداد سوالات : ${widget.exams[i]['question_count']}    مدت آزمون : ${widget.exams[i]['duration']} دقیقه', style: const TextStyle(fontSize: 11)),
                                trailing: IconButton(
                                  onPressed: () => _showConfirmationAlert(context, widget.exams[i]['id']),
                                  icon: const Icon(Icons.play_arrow, color: Colors.green),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
