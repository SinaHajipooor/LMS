import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/providers/Profile/Teaching/NonUniversityTeachingProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/elements/text_input.dart';
import 'package:lms/widgets/elements/three_line_input.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class NonUniversityTeachingForm extends StatefulWidget {
  final bool isCreating;
  final bool isEditing;
  final bool isShowing;
  int? nonUniversityTeachingId;
  NonUniversityTeachingForm({
    super.key,
    this.nonUniversityTeachingId,
    required this.isCreating,
    required this.isEditing,
    required this.isShowing,
  });

  @override
  State<NonUniversityTeachingForm> createState() => _NonUniversityTeachingFormState();
}

class _NonUniversityTeachingFormState extends State<NonUniversityTeachingForm> {
  //-------------- state ------------------
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Map<String, dynamic> nonUniversityTeachingDetails = {};
  bool _isLoading = false;
  File? filePath;
  String startedDate = '';
  String endedDate = '';
  String status = '0';
  String isRelated = '0';
  String isCurrent = '0';
  //-------------- lifecycle ------------------
  @override
  void initState() {
    if (widget.isEditing || widget.isShowing) {
      fetchNonUniversityTeachingDetails();
    }
    super.initState();
  }

  //-------------- methods ------------------
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

  Future<void> _selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );
      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.single.path!);
        if (file.existsSync()) {
          setState(() {
            filePath = file;
          });
        } else {
          throw Exception('File does not exist');
        }
      }
    } catch (error) {
      print(error);
      // Handle the error
    }
  }

  Future<void> fetchNonUniversityTeachingDetails() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<NonUniversityTeachingProvider>(context, listen: false).fetchNonUniversityTeachingDetails(widget.nonUniversityTeachingId!);
    setState(() {
      nonUniversityTeachingDetails = Provider.of<NonUniversityTeachingProvider>(context, listen: false).nonUniverstyTeachingDetails;
      titleController.text = nonUniversityTeachingDetails['title'];
      descriptionController.text = nonUniversityTeachingDetails['activity_description'] ?? '';
      startedDate = nonUniversityTeachingDetails['start_date'].replaceAll('/', '-');
      endedDate = nonUniversityTeachingDetails['end_date'].replaceAll('/', '-');
      status = nonUniversityTeachingDetails['status'] == false ? '0' : '1';
      isRelated = nonUniversityTeachingDetails['is_related'] == false ? '0' : '1';
      isCurrent = nonUniversityTeachingDetails['is_current'] == false ? '0' : '1';

      _isLoading = false;
    });
  }

  Future<void> addNonUniversityTeaching() async {
    setState(() {
      _isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final nonUniversityTeachingInfo = {
      'user_id': userId,
      'title': titleController.text,
      'start_date': startedDate,
      'end_date': endedDate,
      'activity_description': descriptionController.text,
      'status': status,
      'is_related': isRelated,
      'is_current': isCurrent,
    };
    await Provider.of<NonUniversityTeachingProvider>(context, listen: false).addNonUniversityTeaching(nonUniversityTeachingInfo, filePath!);
    Navigator.of(context).pop();
  }

  Future<void> editNonUniversityTeaching() async {
    setState(() {
      _isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final nonUniversityTeachingInfo = {
      'user_id': userId,
      'title': titleController.text,
      'start_date': startedDate,
      'end_date': endedDate,
      'activity_description': descriptionController.text,
      'status': status,
      'is_related': isRelated,
      'is_current': isCurrent,
    };
    await Provider.of<NonUniversityTeachingProvider>(context, listen: false).editNonUniversityTeaching(widget.nonUniversityTeachingId!, nonUniversityTeachingInfo, filePath!);
    Navigator.of(context).pop();
  }

  //-------------- UI ------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scrollbar(
        child: Column(
      children: [
        Expanded(
          child: Form(
            child: _isLoading
                ? const Center(child: Spinner(size: 35))
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextInput(
                                label: 'عنوان',
                                keyboardType: TextInputType.name,
                                controller: titleController,
                                onChanged: (value) {},
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
                                              startedDate,
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
                                              endedDate,
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
                        const SizedBox(height: 20),
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
                                            filePath != null ? 'فایل انتخاب شد' : 'فایل ضمیمه',
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
                                        value: status == '0' ? false : true,
                                        onChanged: (bool value) {
                                          setState(() {
                                            status = value == false ? '0' : '1';
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
                                        value: isRelated == '0' ? false : true,
                                        onChanged: (bool value) {
                                          setState(() {
                                            isRelated = value == false ? '0' : '1';
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
                                        value: isCurrent == '0' ? false : true,
                                        onChanged: (bool value) {
                                          setState(() {
                                            isCurrent = value == false ? '0' : '1';
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
                        ThreeLineInput(controller: descriptionController, label: 'مطالب ارائه شده', onChanged: (value) {}),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
          ),
        ),
        Visibility(
          visible: widget.isCreating || widget.isEditing,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Row(
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
                      onPressed: () {
                        widget.isCreating ? addNonUniversityTeaching() : editNonUniversityTeaching();
                      },
                      child: const Text('ذخیره'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: widget.isShowing,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('بستن'),
                ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
