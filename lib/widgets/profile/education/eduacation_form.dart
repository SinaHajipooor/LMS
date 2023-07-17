import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class EducationForm extends StatefulWidget {
  final bool isEditing;
  final bool isShowing;
  final bool isCreating;
  final Function() fetchAllEducations;
  int? educationId;
  EducationForm({
    super.key,
    required this.isEditing,
    required this.isShowing,
    required this.isCreating,
    required this.fetchAllEducations,
    this.educationId,
  });

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
