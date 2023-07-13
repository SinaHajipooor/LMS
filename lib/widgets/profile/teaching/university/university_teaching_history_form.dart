import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/text_input.dart';
import 'package:lms/widgets/elements/three_line_input.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

// ignore: must_be_immutable
class UniversityTeachingHistoryForm extends StatefulWidget {
  const UniversityTeachingHistoryForm({super.key});

  @override
  State<UniversityTeachingHistoryForm> createState() => _UniversityTeachingHistoryFormState();
}

class _UniversityTeachingHistoryFormState extends State<UniversityTeachingHistoryForm> {
  TextEditingController titleController = TextEditingController();

  bool status = false;
  bool isRelated = false;
  bool isCurrentPosition = false;
  File? _selectedFile;
  String title = '';
  String grade = '';
  String startedDate = '';
  String endedDate = '';
  String description = '';
  String position = '';
  String currentPosition = '';

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

  Future<void> _selecStartedtDate(BuildContext context) async {
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
                  Expanded(child: TextInput(keyboardType: TextInputType.name, label: 'عنوان', onChanged: (value) {}, controller: titleController)),
                  Expanded(child: TextInput(keyboardType: TextInputType.name, label: 'مقطع تحصیلی', onChanged: (value) {}, controller: titleController)),
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
                          _selecStartedtDate(context);
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
                                startedDate == '' ? 'تاریخ شروع' : startedDate,
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
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: TextInput(keyboardType: TextInputType.name, label: 'سمت', onChanged: (value) {}, controller: titleController)),
                  Expanded(child: TextInput(keyboardType: TextInputType.name, label: 'فعالیت جاری', onChanged: (value) {}, controller: titleController)),
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
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('وضعیت', style: theme.bodySmall),
                      CupertinoSwitch(
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
              const SizedBox(height: 10),
              ThreeLineInput(value: '', label: 'توضیحات', onChanged: (value) {}),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
