import 'package:flutter/material.dart';

class ActivitiesInfo extends StatefulWidget {
  final List<dynamic> activitesList;
  const ActivitiesInfo({super.key, required this.activitesList});

  @override
  State<ActivitiesInfo> createState() => _ActivitiesInfoState();
}

class _ActivitiesInfoState extends State<ActivitiesInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Card(
        elevation: 0,
        child: DataTable(
          dividerThickness: 0.5,
          horizontalMargin: 0,
          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade100),
          dataRowHeight: 50,
          columns: const [
            DataColumn(label: Center(child: Text('عنوان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('آدرس', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('سمت', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('زمان شروع', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('زمان پایان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('فعالیت جاری', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('نوع همکاری', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('نمایش', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
          ],
          rows: List<DataRow>.generate(
            widget.activitesList.length,
            (index) => DataRow(
              cells: [
                DataCell(Center(child: Text(widget.activitesList[index]['title'] ?? ''))),
                DataCell(Center(child: Text(widget.activitesList[index]['address'] ?? ''))),
                DataCell(Center(child: Text(widget.activitesList[index]['position'] ?? ''))),
                DataCell(Center(child: Text(widget.activitesList[index]['start_date'] ?? ''))),
                DataCell(Center(child: Text(widget.activitesList[index]['end_date'] ?? ''))),
                DataCell(Center(child: Text(widget.activitesList[index]['current_position'] == false ? 'خیر' : 'بلی'))),
                DataCell(Center(child: Text(widget.activitesList[index]['work_type'] ?? ''))),
                DataCell(
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert, size: 19),
                    elevation: 2,
                    onSelected: (value) {
                      print(value);
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                          child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 8,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 15,
                              child: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white, size: 15),
                                onPressed: () {},
                              ),
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.red,
                              child: IconButton(icon: const Icon(Icons.delete, color: Colors.white, size: 15), onPressed: () {}),
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.blue,
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(Icons.file_copy_outlined, color: Colors.white, size: 15),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                DataCell(
                  IconButton(icon: const Icon(Icons.remove_red_eye, color: Colors.orange, size: 20), onPressed: () {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
