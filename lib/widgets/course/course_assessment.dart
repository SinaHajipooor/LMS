import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../screens/course/course_assessment_screen.dart';

class CourseAssessment extends StatelessWidget {
  // --------------- feilds -----------------
  final int courseId;
  const CourseAssessment({super.key, required this.courseId});
  // --------------- methods -----------------
  _showAlert(BuildContext context, int courseId) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "شروع ارزیابی",
      desc: "آیا مطمعن هستید که ارزیابی را شروع می کنید ؟",
      style: AlertStyle(
        titleStyle: const TextStyle(fontWeight: FontWeight.bold),
        descStyle: const TextStyle(fontSize: 14),
        overlayColor: Colors.black.withOpacity(0.6),
        animationType: AnimationType.fromTop,
        alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide.none),
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed(CourseAssessmentScreen.routeName, arguments: courseId),
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
      closeIcon: const Icon(Icons.close, color: Colors.red),
    ).show();
  }

  // --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => _showAlert(context, courseId),
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
                IconButton(onPressed: () => _showAlert(context, courseId), icon: const Icon(Icons.play_arrow_outlined, color: Colors.green)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
