import 'package:flutter/material.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/widgets/profile/passedCourses/external/external_course_modal.dart';
import 'package:provider/provider.dart';

class ExternalPassedCoursesInfo extends StatefulWidget {
  final List<dynamic> externalCourses;
  final Function(int id, int index) deleteExternalCourse;
  final Function() fetchAllExternalCourses;

  const ExternalPassedCoursesInfo({
    super.key,
    required this.externalCourses,
    required this.deleteExternalCourse,
    required this.fetchAllExternalCourses,
  });

  @override
  State<ExternalPassedCoursesInfo> createState() => _ExternalPassedCoursesInfoState();
}

class _ExternalPassedCoursesInfoState extends State<ExternalPassedCoursesInfo> {
// ---------------- methods -----------------

  _showExternalPassedCoursesInfoModal(
    BuildContext context,
    int externalCourseId,
    int useCase,
  ) {
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
        return ExternalCourseModal(
          fetchAllExternalCourses: widget.fetchAllExternalCourses,
          title: useCase == 1 ? 'ویرایش دوره گذرانده شده خارج مرکز' : 'جزئیات دوره گذرانده شده خارج مرکز',
          externalCourseId: externalCourseId,
          isEditing: useCase == 1,
          isShowing: useCase == 2,
          isCreating: false,
        );
      },
    );
  }

// ---------------- UI -----------------

  // @override
  // Widget build(BuildContext context) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     physics: const BouncingScrollPhysics(),
  //     child: Card(
  //       color: Theme.of(context).cardTheme.color,
  //       elevation: 0,
  //       child: DataTable(
  //         dividerThickness: 0.5,
  //         horizontalMargin: 0,
  //         headingRowColor: MaterialStateColor.resolveWith((states) => Theme.of(context).scaffoldBackgroundColor),
  //         dataRowHeight: 50,
  //         columns: const [
  //           DataColumn(label: Center(child: Text('عنوان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('نام موسسه', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('آدرس', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('زمان شروع', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('زمان پایان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('مدت', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('نمایش', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //         ],
  //         rows: List<DataRow>.generate(
  //           widget.externalCourses.length,
  //           (index) => DataRow(
  //             cells: [
  //               DataCell(Center(child: Text(widget.externalCourses[index]['title'] ?? ''))),
  //               DataCell(Center(child: Text(widget.externalCourses[index]['institute_title'] ?? ''))),
  //               DataCell(Center(child: Text(widget.externalCourses[index]['address'] ?? ''))),
  //               DataCell(Center(child: Text(widget.externalCourses[index]['start_date'] ?? ''))),
  //               DataCell(Center(child: Text(widget.externalCourses[index]['end_date'] ?? ''))),
  //               DataCell(Center(child: Text(widget.externalCourses[index]['duration'] ?? ''))),
  //               DataCell(Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   CircleAvatar(
  //                     backgroundColor: Colors.orange,
  //                     radius: 15,
  //                     child: IconButton(
  //                       icon: const Icon(Icons.edit, color: Colors.white, size: 15),
  //                       onPressed: () => _showExternalPassedCoursesInfoModal(context, widget.externalCourses[index]['id'], 1),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 4),
  //                   CircleAvatar(
  //                     radius: 15,
  //                     backgroundColor: Colors.red,
  //                     child: Center(child: IconButton(icon: const Icon(Icons.delete, color: Colors.white, size: 15), onPressed: () => widget.deleteExternalCourse(widget.externalCourses[index]['id'], index))),
  //                   ),
  //                 ],
  //               )),
  //               DataCell(
  //                 IconButton(
  //                   icon: const Icon(Icons.remove_red_eye, color: Colors.orange, size: 20),
  //                   onPressed: () => _showExternalPassedCoursesInfoModal(
  //                     context,
  //                     widget.externalCourses[index]['id'],
  //                     2,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    final theme = Theme.of(context).textTheme;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.externalCourses.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: themeMode == ThemeMode.dark ? Theme.of(context).cardTheme.color : Colors.grey[300],
            child: Text((index + 1).toString()),
          ),
          title: Text(
            widget.externalCourses[index]['title'],
            style: theme.bodyMedium!.copyWith(fontSize: 14),
          ),
          subtitle: Text(widget.externalCourses[index]['institute_title'], style: theme.bodySmall!.copyWith(fontSize: 11)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 15,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white, size: 15),
                  onPressed: () => _showExternalPassedCoursesInfoModal(context, widget.externalCourses[index]['id'], 1),
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () => widget.deleteExternalCourse(widget.externalCourses[index]['id'], index),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white, size: 15),
                      onPressed: () => widget.deleteExternalCourse(widget.externalCourses[index]['id'], index),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
