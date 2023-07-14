import 'package:flutter/material.dart';
import 'package:lms/widgets/profile/teaching/nonUniversity/non_university_teaching_form.dart';

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
            height: widget.deviceHeight * 0.55,
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
                    child: NonUniversityTeachingForm(
                  isCreating: widget.isCreating,
                  isEditing: widget.isEditing,
                  isShowing: widget.isShowing,
                  nonUniversityTeachingId: widget.nonUniversityTeachingId,
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
