import 'package:flutter/material.dart';
import 'package:lms/providers/Profile/PassedCourses/ExternalPassedCoursesProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/profile/passedCourses/external/external_passed_courses_form.dart';
import 'package:provider/provider.dart';

class ExternalPassedCourseDetailsModal extends StatefulWidget {
  final double deviceHeight;
  // 1 for show 2 for edit
  final int useCase;
  final int externalCourseId;

  const ExternalPassedCourseDetailsModal({
    required this.deviceHeight,
    Key? key,
    required this.useCase,
    required this.externalCourseId,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExternalPassedCourseDetailsModalState createState() => _ExternalPassedCourseDetailsModalState();
}

class _ExternalPassedCourseDetailsModalState extends State<ExternalPassedCourseDetailsModal> {
  // ---------------  state  --------------
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  // ---------------  lifecycle  ---------------
  @override
  void initState() {
    fetchExternalCourseDetails();
    super.initState();
  }

  // ---------------  methods ---------------
  Future<void> fetchExternalCourseDetails() async {
    await Provider.of<ExternalPassedCoursesProvider>(context, listen: false).fetchExternalCourseDetails(widget.externalCourseId);
    setState(() {
      _isLoading = false;
    });
  }
  // ---------------  UI ---------------

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
            child: _isLoading
                ? const Center(child: Spinner(size: 25))
                : Column(
                    children: [
                      Container(
                        height: 50, // adjust as needed
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        child: Text(
                          widget.useCase == 1 ? 'جزئیات دوره گذرانده شده خارج مرکز' : 'ویرایش دوره گذرانده شده خارج مرکز',
                          style: theme.textTheme.titleMedium!.apply(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                          child: ExternalPassedCoursesForm(
                        isCreating: false,
                        isEditing: widget.useCase == 2,
                        externalPassedCourseDetails: Provider.of<ExternalPassedCoursesProvider>(context, listen: false).externalCourseDetails,
                      )),
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
