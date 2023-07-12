import 'package:flutter/material.dart';
import 'package:lms/widgets/profile/passedCourses/external/external_passed_courses_form.dart';

class ExternalPassedCoursesModal extends StatefulWidget {
  final double deviceHeight;
  // final int selectedIndex;

  const ExternalPassedCoursesModal({
    required this.deviceHeight,
    // required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExternalPassedCoursesModalState createState() => _ExternalPassedCoursesModalState();
}

class _ExternalPassedCoursesModalState extends State<ExternalPassedCoursesModal> {
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
                    'ایجاد دوره گذرانده شده خارج مرکز',
                    style: theme.textTheme.titleMedium!.apply(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                const Expanded(child: ExternalPassedCoursesForm(isCreating: true, isEditing: false)),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red[400]!),
                          ),
                          child: const Text('انصراف'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('ذخیره'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
