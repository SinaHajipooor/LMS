import 'package:flutter/material.dart';

class InternalPassedCoursesInfo extends StatefulWidget {
  const InternalPassedCoursesInfo({super.key});

  @override
  State<InternalPassedCoursesInfo> createState() => _InternalPassedCoursesInfoState();
}

class _InternalPassedCoursesInfoState extends State<InternalPassedCoursesInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Card(
        elevation: 1,
        child: DataTable(
          dividerThickness: 0.5,
          horizontalMargin: 0,
          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade100),
          dataRowHeight: 50,
          columns: [
            const DataColumn(label: Center(child: Text('عنوان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('تعداد جلسات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('مدت دوره', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('دانشگاه‌محل‌اخذ‌مدرک', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('مدرسان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('هزینه', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('وضعیت', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
          ],
          rows: [],
        ),
      ),
    );
  }
}
