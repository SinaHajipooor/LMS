import 'package:flutter/material.dart';

class EducationalDocumentScreen extends StatefulWidget {
  const EducationalDocumentScreen({super.key});

  @override
  State<EducationalDocumentScreen> createState() => _EducationalDocumentScreenState();
}

class _EducationalDocumentScreenState extends State<EducationalDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('پرونده آموزشی'),
      ),
    );
  }
}
