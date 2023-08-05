import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/helpers/Theme/theme_helper.dart';
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

  void showInputDialog(int activityId, int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text('این مورد را حذف می‌کنید ؟', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15)),
      ),
      btnOk: ElevatedButton(
        onPressed: () {
          widget.deleteExternalCourse(activityId, index);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        child: const Text('حذف'),
      ),
      btnCancel: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        child: const Text('لغو'),
      ),
    ).show();
  }

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

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    final theme = Theme.of(context).textTheme;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.externalCourses.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0.5,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: ListTile(
            onTap: () => _showExternalPassedCoursesInfoModal(context, widget.externalCourses[index]['id'], 2),
            leading: CircleAvatar(
              backgroundColor: themeMode == ThemeMode.dark ? Theme.of(context).scaffoldBackgroundColor : Colors.grey[300],
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
                InkWell(
                  onTap: () => _showExternalPassedCoursesInfoModal(context, widget.externalCourses[index]['id'], 1),
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 15,
                    child: Image.asset(
                      'assets/images/icons/edit2.png',
                      color: Colors.white,
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () => showInputDialog(widget.externalCourses[index]['id'], index),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red,
                    child: Image.asset(
                      'assets/images/icons/delete.png',
                      width: 18,
                      height: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
