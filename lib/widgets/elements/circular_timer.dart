import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class CircularTimer extends StatelessWidget {
  final int duration;
  final Function onStart;
  final Function onComplete;

  const CircularTimer({
    Key? key,
    required this.duration,
    required this.onStart,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: CircularCountDownTimer(
        duration: duration,
        controller: CountDownController(),
        width: MediaQuery.of(context).size.width / 6,
        height: MediaQuery.of(context).size.height / 8,
        ringColor: Colors.grey,
        ringGradient: null,
        fillColor: Colors.blueAccent,
        fillGradient: null,
        backgroundColor: Colors.transparent,
        backgroundGradient: null,
        strokeWidth: 5.0,
        strokeCap: StrokeCap.round,
        textStyle: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textFormat: CountdownTextFormat.MM_SS,
        isReverse: true,
        isReverseAnimation: true,
        isTimerTextShown: true,
        autoStart: true,
        onStart: () {
          onStart();
        },
        onComplete: () {
          onComplete();
        },
      ),
    );
  }
}
