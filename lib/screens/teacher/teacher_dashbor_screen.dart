import 'package:flutter/material.dart';

class TeacherDashbordScreen extends StatefulWidget {
  const TeacherDashbordScreen({super.key});

  @override
  State<TeacherDashbordScreen> createState() => _TeacherDashbordScreenState();
}

class _TeacherDashbordScreenState extends State<TeacherDashbordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('داشبورد'),
      ),
    );
  }
}
