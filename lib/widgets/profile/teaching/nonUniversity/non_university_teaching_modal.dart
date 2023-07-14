import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NonUniversityTeachingModal extends StatefulWidget {
  final String title;
  final double deviceHeight;
  final bool isCreating;
  final bool isEditing;
  final bool isShowing;
  int? nonUniversityTeachingId;
  NonUniversityTeachingModal({
    super.key,
    required this.title,
    required this.deviceHeight,
    required this.isCreating,
    required this.isEditing,
    required this.isShowing,
    this.nonUniversityTeachingId,
  });

  @override
  State<NonUniversityTeachingModal> createState() => _NonUniversityTeachingModalState();
}

class _NonUniversityTeachingModalState extends State<NonUniversityTeachingModal> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
