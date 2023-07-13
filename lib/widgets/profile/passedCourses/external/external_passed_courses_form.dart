import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/text_input.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class ExternalPassedCoursesForm extends StatefulWidget {
  final bool isCreating;
  final bool isEditing;
  final Map<String, dynamic>? externalPassedCourseDetails;
  final Map<dynamic, dynamic> externalPassedCourseInfo;
  final Future<void> Function() selectFile;
  const ExternalPassedCoursesForm({super.key, required this.isCreating, required this.isEditing, this.externalPassedCourseDetails, required this.externalPassedCourseInfo, required this.selectFile});

  @override
  State<ExternalPassedCoursesForm> createState() => _ExternalPassedCoursesFormState();
}

class _ExternalPassedCoursesFormState extends State<ExternalPassedCoursesForm> {
  Future<void> _selectStartedDate(BuildContext context) async {
    final Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1300, 1, 1),
      lastDate: Jalali.now(),
      locale: const Locale('fa'),
    );

    if (picked != null) {
      final String formattedDate = picked.toJalaliDateTime().substring(0, 10);
      setState(() {
        widget.externalPassedCourseInfo['start_date'] = formattedDate;
      });
    }
  }

  Future<void> _selectEndedDate(BuildContext context) async {
    final Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1300, 1, 1),
      lastDate: Jalali.now(),
      locale: const Locale('fa'),
    );

    if (picked != null) {
      final String formattedDate = picked.toJalaliDateTime().substring(0, 10);
      setState(() {
        widget.externalPassedCourseInfo['end_date'] = formattedDate;
      });
    }
  }

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
                      value: widget.isCreating ? widget.externalPassedCourseInfo['title'] : widget.externalPassedCourseDetails?['title'],
                      label: 'عنوان',
                      onChanged: (value) {
                        widget.externalPassedCourseInfo['title'] = value;
                      },
                      editable: widget.isEditing,
                    ),
                  ),
                  Expanded(
                    child: TextInput(
                      value: widget.isCreating ? widget.externalPassedCourseInfo['institute_title'] : widget.externalPassedCourseDetails?['institute_title'],
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
                              _selectStartedDate(context);
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
                                    widget.isCreating ? widget.externalPassedCourseInfo['start_date'] : widget.externalPassedCourseDetails?['start_date'],
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
                              _selectEndedDate(context);
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
                                    widget.isCreating ? widget.externalPassedCourseInfo['end_date'] : widget.externalPassedCourseDetails?['end_date'],
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
                      value: widget.isCreating ? widget.externalPassedCourseInfo['address'] : widget.externalPassedCourseDetails?['address'],
                      label: 'آدرس',
                      onChanged: (value) {
                        widget.externalPassedCourseInfo['address'] = value;
                      },
                      editable: widget.isEditing,
                    ),
                  ),
                  Expanded(
                    child: TextInput(
                      value: widget.isCreating ? widget.externalPassedCourseInfo['duration'] : (widget.externalPassedCourseDetails?['duration'] ?? ''),
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
                              value: widget.isCreating ? widget.externalPassedCourseInfo['status'] : (widget.externalPassedCourseDetails?['status'] == '0' ? false : true),
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
                              value: widget.isCreating ? widget.externalPassedCourseInfo['is_related'] : (widget.externalPassedCourseDetails?['is_related'] == '0' ? false : true),
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
                              value: widget.isCreating ? widget.externalPassedCourseInfo['has_certificate'] : (widget.externalPassedCourseDetails?['has_certificate'] == '0' ? false : true),
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
