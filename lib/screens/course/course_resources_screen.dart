import 'package:flutter/material.dart';
import 'package:lms/widgets/course/recourses/course_resources_list.dart';

class CourseResourcesScreen extends StatefulWidget {
// ------------------- feilds ----------------------
  final List resources;
  final String imageUrl;
  final int courseId;
  final String courseName;
  final int studentsCount;
  final String coursePeriod;
  const CourseResourcesScreen({super.key, required this.resources, required this.courseId, required this.imageUrl, required this.courseName, required this.studentsCount, required this.coursePeriod});

  @override
  State<CourseResourcesScreen> createState() => _CourseResourcesScreenState();
}

class _CourseResourcesScreenState extends State<CourseResourcesScreen> {
// ------------------- UI ----------------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('منابع آموزشی', style: TextStyle(fontSize: 16, color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: deviceSize.height * 0.35,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(widget.imageUrl, fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(widget.courseName, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              CourseResourcesList(
                resources: widget.resources,
                courseId: widget.courseId,
              )
            ],
          ),
        ),
      ),
    );
  }
}
