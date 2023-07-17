import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class JobForm extends StatefulWidget {
  final bool isCreating;
  final bool isEditing;
  final bool isShowing;
  final Function() fetchAllJobs;
  int? jobId;
  JobForm({super.key, this.jobId, required this.isCreating, required this.isEditing, required this.isShowing, required this.fetchAllJobs});

  @override
  State<JobForm> createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
