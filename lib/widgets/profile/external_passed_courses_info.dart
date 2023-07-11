import 'package:flutter/material.dart';

class ExternalPassedCoursesInfo extends StatefulWidget {
  const ExternalPassedCoursesInfo({super.key});

  @override
  State<ExternalPassedCoursesInfo> createState() => _ExternalPassedCoursesInfoState();
}

class _ExternalPassedCoursesInfoState extends State<ExternalPassedCoursesInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        elevation: 1,
        child: DataTable(
          dividerThickness: 0.5,
          horizontalMargin: 0,
          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade100),
          dataRowHeight: 50,
          columns: [
            const DataColumn(label: Center(child: Text('عنوان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('نام موسسه', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('آدرس', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('زمان شروع', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('زمان پایان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('مدت', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            const DataColumn(label: Center(child: Text('انتخاب', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
          ],
          rows: [],
          // rows: _data.map((item) {
          //   return DataRow(
          //     cells: [
          //       DataCell(
          //         Center(
          //           child: Container(
          //             decoration: BoxDecoration(
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withOpacity(0.2),
          //                   spreadRadius: 2,
          //                   blurRadius: 4,
          //                   offset: const Offset(2, 0),
          //                 ),
          //               ],
          //             ),
          //             child: Text(item['id']!, style: const TextStyle(fontSize: 12)),
          //           ),
          //         ),
          //       ),
          //       DataCell(Center(child: Text(item['device']!, style: const TextStyle(fontSize: 12)))),
          //       DataCell(Center(child: Text(item['device']!, style: const TextStyle(fontSize: 12)))),
          //       DataCell(Center(child: Text(item['device']!, style: const TextStyle(fontSize: 12)))),
          //       DataCell(
          //         PopupMenuButton(
          //           icon: const Icon(Icons.more_vert, size: 19),
          //           elevation: 2,
          //           onSelected: (value) {
          //             print(value);
          //           },
          //           itemBuilder: (BuildContext context) => [
          //             const PopupMenuItem(
          //               child: SizedBox(
          //                 width: 110,
          //                 child: SingleChildScrollView(
          //                   scrollDirection: Axis.horizontal,
          //                   child: Row(
          //                     children: [
          //                       PopupMenuItem(
          //                         value: 'edit',
          //                         child: Icon(Icons.edit, color: Colors.orange, size: 20),
          //                       ),
          //                       PopupMenuItem(
          //                         padding: EdgeInsets.only(left: 1),
          //                         value: 'delete',
          //                         child: Icon(Icons.delete, color: Colors.red, size: 20),
          //                       ),
          //                       PopupMenuItem(
          //                         value: 'detail',
          //                         child: Icon(Icons.file_copy_outlined, color: Colors.blue, size: 20),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       DataCell(
          //         Checkbox(
          //           value: item['checked'] == 'true',
          //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          //           onChanged: (value) {
          //             setState(() {
          //               item['checked'] = value.toString();
          //             });
          //           },
          //         ),
          //       ),
          //     ],
          //   );
          // }).toList(),
        ),
      ),
    );
  }
}
