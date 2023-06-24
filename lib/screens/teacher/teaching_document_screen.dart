import 'package:flutter/material.dart';

class TeachingDocumentScreen extends StatefulWidget {
  const TeachingDocumentScreen({super.key});

  @override
  State<TeachingDocumentScreen> createState() => _TeachingDocumentScreenState();
}

class _TeachingDocumentScreenState extends State<TeachingDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پرونده تدریس'),
      ),
    );
  }
}
