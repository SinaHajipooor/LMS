import 'package:flutter/material.dart';
import 'package:lms/widgets/profile/passedCourses/new/external_course_from.dart';

class ExternalCourseCreateModal extends StatefulWidget {
  const ExternalCourseCreateModal({super.key});

  @override
  State<ExternalCourseCreateModal> createState() => _ExternalCourseCreateModalState();
}

class _ExternalCourseCreateModalState extends State<ExternalCourseCreateModal> {
  //---------------- state ------------------
  final ScrollController _scrollController = ScrollController();

  //---------------- UI ------------------

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
            height: MediaQuery.of(context).size.height * 0.55,
            child: Column(
              children: [
                Container(
                  height: 50, // adjust as needed
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    'ایجاد دوره گذرانده شده خارج مرکز',
                    style: theme.textTheme.titleMedium!.apply(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                const Expanded(child: ExternalCourseForm()),
              ],
            ),
          ),
        );
      },
    );
  }
}
