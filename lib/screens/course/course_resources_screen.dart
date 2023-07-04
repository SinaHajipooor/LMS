import 'package:flutter/material.dart';
import 'package:lms/widgets/course/course_resources_list.dart';

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
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                spreadRadius: -2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            widget.courseName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('مدت دوره : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(widget.coursePeriod, style: const TextStyle(fontSize: 17, color: Colors.blue)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'تعداد فراگیران : ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.studentsCount.toString(),
                          style: const TextStyle(fontSize: 17, color: Colors.green),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              CourseResourcesList(
                resources: widget.resources,
                courseId: widget.courseId,
              )
            ],
          ),
        )));
  }
}
