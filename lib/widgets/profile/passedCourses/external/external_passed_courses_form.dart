import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/text_input.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class ExternalPassedCoursesForm extends StatefulWidget {
  final bool isCreating;
  final bool isEditing;
  final Map<String, dynamic>? externalPassedCourseDetails;
  const ExternalPassedCoursesForm({super.key, required this.isCreating, required this.isEditing, this.externalPassedCourseDetails});

  @override
  State<ExternalPassedCoursesForm> createState() => _ExternalPassedCoursesFormState();
}

class _ExternalPassedCoursesFormState extends State<ExternalPassedCoursesForm> {
  bool status = false;
  bool isRelated = false;
  bool hasCertificate = false;
  File? _selectedFile;
  String title = '';
  String instituteTittle = '';
  String startedDate = '';
  String endedDate = '';
  String position = '';
  String currentPosition = '';
  String description = '';
  String address = '';
  String duration = '';
  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

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
        startedDate = formattedDate;
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
        endedDate = formattedDate;
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
                  Expanded(child: TextInput(value: widget.isCreating ? title : widget.externalPassedCourseDetails?['title'], label: 'عنوان', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(value: widget.isCreating ? instituteTittle : widget.externalPassedCourseDetails?['institute_title'], label: 'نام موسسه', onChanged: (value) {}, keyboardType: TextInputType.number)),
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
                                    widget.isCreating ? startedDate : widget.externalPassedCourseDetails?['start_date'],
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
                                    widget.isCreating ? endedDate : widget.externalPassedCourseDetails?['end_date'],
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
                  Expanded(child: TextInput(value: widget.isCreating ? address : widget.externalPassedCourseDetails?['address'], label: 'آدرس', onChanged: (value) {})),
                  Expanded(child: TextInput(value: widget.isCreating ? duration : widget.externalPassedCourseDetails?['duration'], label: 'مدت', onChanged: (value) {}, keyboardType: TextInputType.number)),
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
                        onTap: () => _selectFile(),
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
                                  _selectedFile != null ? 'فایل انتخاب شد' : 'فایل ضمیمه',
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
                              value: widget.isCreating ? status : (widget.externalPassedCourseDetails?['status'] == '0' ? false : true),
                              onChanged: (bool value) {
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('فعالیت مرتبط', style: theme.bodySmall),
                            CupertinoSwitch(
                              activeColor: Colors.blue,
                              value: widget.isCreating ? isRelated : (widget.externalPassedCourseDetails?['is_related'] == '0' ? false : true),
                              onChanged: (bool value) {
                                setState(() {
                                  isRelated = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('گواهینامه', style: theme.bodySmall),
                            CupertinoSwitch(
                              activeColor: Colors.blue,
                              value: widget.isCreating ? hasCertificate : (widget.externalPassedCourseDetails?['has_certificate'] == '0' ? false : true),
                              onChanged: (bool value) {
                                setState(() {
                                  hasCertificate = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
