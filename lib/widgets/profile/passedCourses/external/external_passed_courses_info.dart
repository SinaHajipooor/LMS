import 'package:flutter/material.dart';

class ExternalPassedCoursesInfo extends StatefulWidget {
  final List<dynamic> externalCourses;
  const ExternalPassedCoursesInfo({super.key, required this.externalCourses});

  @override
  State<ExternalPassedCoursesInfo> createState() => _ExternalPassedCoursesInfoState();
}

class _ExternalPassedCoursesInfoState extends State<ExternalPassedCoursesInfo> {
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
          columns: const [
            DataColumn(label: Center(child: Text('عنوان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('نام موسسه', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('آدرس', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('زمان شروع', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('زمان پایان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('مدت', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('انتخاب', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
          ],
          rows: [],
        ),
      ),
    );
  }
}
