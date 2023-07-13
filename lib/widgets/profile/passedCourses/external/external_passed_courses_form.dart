import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/text_input.dart';

class ExternalPassedCoursesForm extends StatefulWidget {
  final bool isCreating;
  final bool isEditing;
  final bool hasCertificate;
  final bool isRelated;
  final bool status;
  String? title;
  final String startedDate;
  final String endedDate;
  final TextEditingController titleController;
  final TextEditingController instituteNammeController;
  final TextEditingController startedDateController;
  final TextEditingController endedDateController;
  final TextEditingController addressController;
  final TextEditingController durationController;
  final Map<String, dynamic> externalPassedCourseDetails;
  final Map<dynamic, dynamic> externalPassedCourseInfo;
  final Future<void> Function() selectFile;
  final Future<void> Function(BuildContext context) selectStartedDate;
  final Future<void> Function(BuildContext context) selectEndedDate;
  ExternalPassedCoursesForm({
    super.key,
    required this.isCreating,
    required this.isEditing,
    this.title,
    required this.externalPassedCourseDetails,
    required this.externalPassedCourseInfo,
    required this.selectFile,
    required this.hasCertificate,
    required this.isRelated,
    required this.status,
    required this.titleController,
    required this.instituteNammeController,
    required this.startedDateController,
    required this.endedDateController,
    required this.addressController,
    required this.durationController,
    required this.startedDate,
    required this.endedDate,
    required this.selectStartedDate,
    required this.selectEndedDate,
  });

  @override
  State<ExternalPassedCoursesForm> createState() => _ExternalPassedCoursesFormState();
}

class _ExternalPassedCoursesFormState extends State<ExternalPassedCoursesForm> {
// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scrollbar(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextInput(
                      // initialValue: widget.title,
                      controller: widget.titleController,
                      keyboardType: TextInputType.name,
                      label: 'عنوان',
                      onChanged: (value) {
                        widget.externalPassedCourseInfo['title'] = value;
                      },
                      editable: widget.isEditing,
                    ),
                  ),
                  Expanded(
                    child: TextInput(
                      controller: widget.instituteNammeController,
                      keyboardType: TextInputType.name,
                      label: 'نام موسسه',
                      onChanged: (value) {
                        widget.externalPassedCourseInfo['institute_title'] = value;
                      },
                      editable: widget.isEditing,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            'تاریخ شروع',
                            style: theme.bodySmall,
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 1,
                          child: InkWell(
                            onTap: () {
                              widget.selectStartedDate(context);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 20),
                                  const SizedBox(width: 16),
                                  Text(
                                    widget.startedDate,
                                    style: theme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text('تاریخ پایان', style: theme.bodySmall),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 1,
                          child: InkWell(
                            onTap: () {
                              widget.selectEndedDate(context);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 20),
                                  const SizedBox(width: 16),
                                  Text(
                                    widget.endedDate,
                                    style: theme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextInput(
                      controller: widget.addressController,
                      keyboardType: TextInputType.name,
                      label: 'آدرس',
                      onChanged: (value) {
                        widget.externalPassedCourseInfo['address'] = value;
                      },
                      editable: widget.isEditing,
                    ),
                  ),
                  Expanded(
                    child: TextInput(
                      controller: widget.durationController,
                      label: 'مدت',
                      onChanged: (value) {
                        widget.externalPassedCourseInfo['duration'] = value;
                      },
                      keyboardType: TextInputType.number,
                      editable: widget.isEditing,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 1,
                      child: InkWell(
                        onTap: () => widget.selectFile(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.attach_file),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  widget.externalPassedCourseInfo['file'] != null ? 'فایل انتخاب شد' : 'فایل ضمیمه',
                                  style: const TextStyle(fontSize: 11),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('وضعیت', style: theme.bodySmall),
                            CupertinoSwitch(
                              activeColor: Colors.blue,
                              value: widget.status,
                              onChanged: (bool value) {
                                widget.isEditing
                                    ? setState(() {
                                        widget.externalPassedCourseInfo['status'] = value;
                                      })
                                    : null;
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('فعالیت مرتبط', style: theme.bodySmall),
                            CupertinoSwitch(
                              activeColor: Colors.blue,
                              value: widget.isRelated,
                              onChanged: (bool value) {
                                widget.isEditing
                                    ? setState(() {
                                        widget.externalPassedCourseInfo['is_related'] = value;
                                      })
                                    : null;
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('گواهینامه', style: theme.bodySmall),
                            CupertinoSwitch(
                              activeColor: Colors.blue,
                              value: widget.hasCertificate,
                              onChanged: (bool value) {
                                widget.isEditing
                                    ? setState(
                                        () {
                                          widget.externalPassedCourseInfo['has_certificate'] = value;
                                        },
                                      )
                                    : null;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
