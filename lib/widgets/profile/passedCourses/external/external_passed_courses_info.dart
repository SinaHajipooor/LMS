import 'package:flutter/material.dart';
import 'package:lms/widgets/profile/passedCourses/external/external_passed_courses_modal.dart';

class ExternalPassedCoursesInfo extends StatefulWidget {
  final List<dynamic> externalCourses;
  const ExternalPassedCoursesInfo({super.key, required this.externalCourses});

  @override
  State<ExternalPassedCoursesInfo> createState() => _ExternalPassedCoursesInfoState();
}

class _ExternalPassedCoursesInfoState extends State<ExternalPassedCoursesInfo> {
  _showExternalPassedCoursesInfoModal(BuildContext context, double deviceHeight) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ExternalPassedCoursesModal(deviceHeight: deviceHeight);
      },
    );
  }

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
            DataColumn(label: Center(child: Text('نام موسسه', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('آدرس', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('زمان شروع', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('زمان پایان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('مدت', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('نمایش', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
          ],
          rows: List<DataRow>.generate(
            widget.externalCourses.length,
            (index) => DataRow(
              cells: [
                DataCell(Center(child: Text(widget.externalCourses[index]['title'] ?? ''))),
                DataCell(Center(child: Text(widget.externalCourses[index]['institute_title'] ?? ''))),
                DataCell(Center(child: Text(widget.externalCourses[index]['address'] ?? ''))),
                DataCell(Center(child: Text(widget.externalCourses[index]['start_date'] ?? ''))),
                DataCell(Center(child: Text(widget.externalCourses[index]['end_date'] ?? ''))),
                DataCell(Center(child: Text(widget.externalCourses[index]['duration'] ?? ''))),
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
                                onPressed: () {
                                  // Handle edit action
                                },
                              ),
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.red,
                              child: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.white, size: 15),
                                onPressed: () {
                                  // Handle delete action
                                },
                              ),
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
                DataCell(IconButton(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.orange, size: 20),
                  onPressed: () => _showExternalPassedCoursesInfoModal(context, MediaQuery.of(context).size.height),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
