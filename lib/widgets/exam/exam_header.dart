import 'package:flutter/material.dart';
import '../elements/circular_timer.dart';

class ExamHeader extends StatelessWidget {
  final Function(BuildContext context, int courseId) finishExam;
  const ExamHeader({super.key, required this.finishExam});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 5, right: 5),
      child: Card(
        elevation: 1,
        shadowColor: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'به نام خدا',
                  style: theme.textTheme.titleLarge,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('نام دوره : ', style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text('نام درس : ', style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text('تعداد سوالات : ', style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
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
