import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/profile/job/job_form.dart';

// ignore: must_be_immutable
class JobModal extends StatefulWidget {
  final double deviceHeight;
  int? jobId;
  final Function() fetchAllJobs;
  final bool isEditing;
  final bool isCreating;
  final bool isShowing;
  final String title;
  JobModal({
    super.key,
    this.jobId,
    required this.deviceHeight,
    required this.isEditing,
    required this.isCreating,
    required this.isShowing,
    required this.title,
    required this.fetchAllJobs,
  });

  @override
  State<JobModal> createState() => _JobModalState();
}

class _JobModalState extends State<JobModal> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final keyboardOffset = MediaQuery.of(context).viewInsets.bottom;
    final theme = Theme.of(context);
    return StatefulBuilder(
      builder: (context, setState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (keyboardOffset > 0) {
            setState(() {
              _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
              );
            });
          }
        });
        return SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(
            bottom: keyboardOffset + MediaQuery.of(context).padding.bottom,
          ),
          child: SizedBox(
            height: widget.deviceHeight * 0.6,
            child: Column(
              children: [
                Container(
                  height: 50, // adjust as needed
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    style: theme.textTheme.titleMedium!.apply(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: JobForm(
                  fetchAllJobs: widget.fetchAllJobs,
                  isCreating: widget.isCreating,
                  isEditing: widget.isEditing,
                  isShowing: widget.isShowing,
                  jobId: widget.jobId,
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
