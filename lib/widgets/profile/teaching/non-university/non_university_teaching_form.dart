import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/text_input.dart';
import 'package:lms/widgets/elements/three_line_input.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class NonUniversityTeachingForm extends StatefulWidget {
  const NonUniversityTeachingForm({super.key});

  @override
  State<NonUniversityTeachingForm> createState() => _NonUniversityTeachingFormState();
}

class _NonUniversityTeachingFormState extends State<NonUniversityTeachingForm> {
  TextEditingController titleController = TextEditingController();

  bool status = false;
  bool isRelated = false;
  bool isCurrentPosition = false;
  File? _selectedFile;
  String title = '';
  String address = '';
  String startedDate = '';
  String endedDate = '';
  String position = '';
  String currentPosition = '';
  String description = '';
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
                    keyboardType: TextInputType.name,
                    label: 'عنوان',
                    onChanged: (value) {},
                    controller: titleController,
                  )),
                  Expanded(child: TextInput(controller: titleController, keyboardType: TextInputType.name, label: 'مطالب ارائه شده', onChanged: (value) {})),
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
                                startedDate == '' ? 'تاریخ شروع' : endedDate,
                                style: theme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
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
                                endedDate == '' ? 'تاریخ پایان' : endedDate,
                                style: theme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(children: [
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
              ]),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('وضعیت', style: theme.bodySmall),
                      CupertinoSwitch(
                        activeColor: Colors.blue,
                        value: status,
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
                        value: isRelated,
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
                      Text('فعالیت جاری', style: theme.bodySmall),
                      CupertinoSwitch(
                        activeColor: Colors.blue,
                        value: isCurrentPosition,
                        onChanged: (bool value) {
                          setState(() {
                            isCurrentPosition = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ThreeLineInput(controller: titleController, label: 'توضیحات', onChanged: (value) {}),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
