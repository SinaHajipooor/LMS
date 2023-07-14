import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UniversityTeachingModal extends StatefulWidget {
  final String title;
  final double deviceHeight;
  final bool isCreating;
  final bool isEditing;
  final bool isShowing;
  int? universityTeachingId;
  UniversityTeachingModal({
    super.key,
    this.universityTeachingId,
    required this.title,
    required this.isCreating,
    required this.isEditing,
    required this.isShowing,
    required this.deviceHeight,
  });

  @override
  State<UniversityTeachingModal> createState() => _UniversityTeachingModalState();
}

class _UniversityTeachingModalState extends State<UniversityTeachingModal> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
