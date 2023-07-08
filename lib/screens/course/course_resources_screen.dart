import 'package:flutter/material.dart';
import 'package:lms/widgets/course/recourses/course_resources_list.dart';
import 'package:lms/widgets/course/recourses/network_video_player.dart';

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
        elevation: 1,
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
                          borderRadius: BorderRadius.circular(10),
                          child: const Directionality(
                            textDirection: TextDirection.ltr,
                            child: NetworkVideoPlayer(videoUrl: 'https://www.uplooder.net/f/tl/70/4cde8767d5e4e5ba6480165bc3437431/8.-Adding-Another-Piece-of-State.mp4'),
                          ),
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
