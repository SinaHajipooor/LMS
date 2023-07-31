import 'package:flutter/material.dart';
import 'package:lms/providers/Course/ElectronicCourseProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:provider/provider.dart';
import 'electronic_course_item.dart';

class ElectronicCoursesList extends StatefulWidget {
  // -------------- feilds ----------------
  // final bool showItems;
  final int groupId;
  const ElectronicCoursesList({super.key, required this.groupId});

  @override
  State<ElectronicCoursesList> createState() => _ElectronicCoursesListState();
}

class _ElectronicCoursesListState extends State<ElectronicCoursesList> {
//------------------ state -------------------
  List<dynamic> electronicCourses = [];
  bool _isLoading = true;
//------------------ lifecycle -------------------

  @override
  void initState() {
    fetchElectronicCourseById();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//------------------ methods -------------------
  Future<void> fetchElectronicCourseById() async {
    electronicCourses = await Provider.of<ElectronicCourseProvider>(context, listen: false).fetchElectronicCoursesByGroupId(widget.groupId);
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

//------------------ UI -------------------
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: Spinner(size: 35))
        : Visibility(
            visible: electronicCourses.isNotEmpty,
            replacement: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/icons/not-found.png', width: 100, height: 80),
                const SizedBox(height: 20),
                Text('دوره‌ای وجود ندارد !', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal)),
              ],
            ),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: electronicCourses.length,
              itemBuilder: (ctx, i) => ElectronicCourseItem(
                courseId: electronicCourses[i]['id'] ?? 0,
                eduId: electronicCourses[i]['edu_id'] ?? 0,
                courseTitle: electronicCourses[i]['title'] ?? '_',
                coursePrice: electronicCourses[i]['final_amount'] ?? '_',
                courseTime: electronicCourses[i]['time'] ?? '_',
                courseImage: electronicCourses[i]['main_image'] ?? '',
                teacherName: electronicCourses[i]['teacher']?['name'] ?? 'مشخص نمی‌باشد',
                courseSessions: electronicCourses[i]['sessions'] ?? 0,
              ),
            ),
          );
  }
}
