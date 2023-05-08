import 'package:flutter/material.dart';

class CourseDetailCards extends StatelessWidget {
  //---------------- feilds ------------------
  final int seasonsCount;
  final int sessionCount;
  final String time;
  final int studentsCount;
  final String lessonName;

  const CourseDetailCards({
    super.key,
    required this.seasonsCount,
    required this.sessionCount,
    required this.time,
    required this.studentsCount,
    required this.lessonName,
  });
  //---------------- UI ------------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: 70,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: deviceSize.width / 5,
              child: Card(
                elevation: 1,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('تعداد فصل‌ها', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  Text(seasonsCount.toString(), style: const TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            Container(
              width: deviceSize.width / 5,
              child: Card(
                elevation: 1,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('تعداد جلسات', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  Text(sessionCount.toString(), style: const TextStyle(fontSize: 13, color: Colors.red, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            Container(
              width: deviceSize.width / 5,
              child: Card(
                elevation: 1,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('مدت دوره', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  Text(time.toString(), style: const TextStyle(fontSize: 12)),
                ]),
              ),
            ),
            Container(
              width: deviceSize.width / 5,
              child: Card(
                elevation: 1,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('تعداد فراگیر', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  Text(studentsCount.toString(), style: const TextStyle(fontSize: 13, color: Colors.orange, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            Container(
              width: deviceSize.width / 5,
              child: Card(
                elevation: 1,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('نام درس', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Text(lessonName, style: const TextStyle(fontSize: 11)),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
