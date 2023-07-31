import 'package:flutter/material.dart';
import 'package:lms/providers/Course/SimpleCourseProvider.dart';
import 'package:lms/widgets/course/simple/simple_course_item.dart';
import 'package:provider/provider.dart';

class SimpleCoursesList extends StatefulWidget {
  // -------------- feilds ----------------

  final int groupId;
  const SimpleCoursesList({super.key, required this.groupId});

  @override
  State<SimpleCoursesList> createState() => _SimpleCoursesListState();
}

class _SimpleCoursesListState extends State<SimpleCoursesList> {
//------------------ state -------------------
  List<dynamic> simpleCourses = [];
//------------------ lifecycle -------------------

  @override
  void initState() {
    fetchSimpleCourseById();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//------------------ methods -------------------
  Future<void> fetchSimpleCourseById() async {
    simpleCourses = await Provider.of<SimpleCourseProvider>(context, listen: false).fetchSimpleCoursesByGroupId(widget.groupId);
    if (mounted) {
      setState(() {});
    }
  }

//------------------ UI -------------------
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: simpleCourses.isNotEmpty,
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
        itemCount: simpleCourses.length,
        itemBuilder: (ctx, i) => SimpleCourseItem(
          courseId: simpleCourses[i]['id'] ?? 0,
          eduId: simpleCourses[i]['edu_id'] ?? 0,
          courseTitle: simpleCourses[i]['title'] ?? '_',
          coursePrice: simpleCourses[i]['final_amount'] ?? '_',
          courseTime: simpleCourses[i]['time'] ?? '_',
          courseImage: simpleCourses[i]['main_image'] ?? '',
          teacherName: simpleCourses[i]['teacher']?['name'] ?? 'مشخص نمی‌باشد',
          meetings: simpleCourses[i]['meetings'] ?? 0,
        ),
      ),
    );
  }
}
