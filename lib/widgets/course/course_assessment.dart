import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../../screens/course/course_assessment_screen.dart';

class CourseAssessment extends StatelessWidget {
  // --------------- feilds -----------------
  final int courseId;
  const CourseAssessment({super.key, required this.courseId});
  // --------------- methods -----------------
  // _showAlert(BuildContext context, int courseId) {
  //   Alert(
  //     context: context,
  //     type: AlertType.warning,
  //     title: "شروع ارزیابی",
  //     desc: "آیا مطمعن هستید که ارزیابی را شروع می کنید ؟",
  //     style: AlertStyle(
  //       titleStyle: const TextStyle(fontWeight: FontWeight.bold),
  //       descStyle: const TextStyle(fontSize: 14),
  //       overlayColor: Colors.black.withOpacity(0.6),
  //       animationType: AnimationType.fromTop,
  //       alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide.none),
  //     ),
  //     buttons: [
  //       DialogButton(
  //         onPressed: () => Navigator.of(context).pushReplacementNamed(CourseAssessmentScreen.routeName, arguments: courseId),
  //         width: 120,
  //         color: Colors.green,
  //         child: const Text("بله", style: TextStyle(color: Colors.white, fontSize: 20)),
  //       ),
  //       DialogButton(
  //         onPressed: () => Navigator.of(context).pop(),
  //         width: 120,
  //         color: Colors.red[400],
  //         child: const Text("خیر", style: TextStyle(color: Colors.white, fontSize: 20)),
  //       ),
  //     ],
  //     closeIcon: const Icon(Icons.close, color: Colors.red),
  //   ).show();
  // }

  void _showConfirmationAlert(BuildContext context, int courseId) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: 'شروع ارزیابی',
      titleTextStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
      desc: 'آیا مطمعن هستید که ارزیابی را شروع می کنید ؟',
      descTextStyle: const TextStyle(fontSize: 13),
      btnCancelColor: Colors.red,
      btnOkColor: const Color.fromARGB(255, 99, 223, 103),
      btnOkText: 'بله',
      buttonsBorderRadius: BorderRadius.circular(9),
      btnCancelText: 'لغو',
      buttonsTextStyle: const TextStyle(fontSize: 15),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.of(context).pushReplacementNamed(CourseAssessmentScreen.routeName, arguments: courseId);
      },
    ).show();
  }

  // --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => _showConfirmationAlert(context, courseId),
      child: SizedBox(
        width: deviceSize.width / 2,
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('ارزیابی اثربخشی', style: TextStyle(fontSize: 13)),
                IconButton(onPressed: () => _showConfirmationAlert(context, courseId), icon: const Icon(Icons.play_arrow_outlined, color: Colors.green)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
