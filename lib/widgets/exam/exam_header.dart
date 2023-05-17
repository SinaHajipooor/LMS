import 'package:flutter/material.dart';
import '../elements/circular_timer.dart';

class ExamHeader extends StatelessWidget {
  final Function finishExam;
  const ExamHeader({super.key, required this.finishExam});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Card(
        elevation: 1,
        shadowColor: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'به نام خدا',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('نام دوره : ', style: TextStyle(fontSize: 13)),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text('نام درس : ', style: TextStyle(fontSize: 13)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text('تعداد سوالات : ', style: TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                  CircularTimer(duration: 90, onStart: () {}, onComplete: finishExam)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
