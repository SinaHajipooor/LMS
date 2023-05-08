import 'package:flutter/material.dart';
import '../../widgets/course/course_season_card.dart';

class CourseResourcesScreen extends StatefulWidget {
// ------------------- feilds ----------------------
  final List resources;
  final int courseId;
  const CourseResourcesScreen({super.key, required this.resources, required this.courseId});

  @override
  State<CourseResourcesScreen> createState() => _CourseResourcesScreenState();
}

class _CourseResourcesScreenState extends State<CourseResourcesScreen> {
// ------------------- UI ----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('منابع آموزشی', style: TextStyle(fontSize: 16, color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.resources.length,
        itemBuilder: (ctx, i) => Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CourseSeasonCard(
            title: widget.resources[i]['title'],
            sessions: widget.resources[i]['sessions'],
          ),
        ),
      ),
    );
  }
}
