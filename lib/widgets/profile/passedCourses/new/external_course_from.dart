import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/providers/Profile/PassedCourses/ExternalPassedCoursesProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/elements/text_input.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExternalCourseForm extends StatefulWidget {
  const ExternalCourseForm({super.key});

  @override
  State<ExternalCourseForm> createState() => _ExternalCourseFormState();
}

class _ExternalCourseFormState extends State<ExternalCourseForm> {
  //------------------- state ----------------------
  final TextEditingController titleController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  String startedDate = '';
  String endedDate = '';
  bool isRelated = false;
  bool hasCertificate = false;
  bool status = false;
  File? filePath;
  bool _isLoading = false;
  //------------------- lifecycle ----------------------

  //------------------- methods ----------------------

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

  Future<void> addExternalCourse() async {
    setState(() {
      _isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final externalCourseInfo = {
      'user_id': userId,
      'title': titleController.text,
      'institute_title': instituteController.text,
      'duration': durationController.text,
      'address': addressController.text,
      'start_date': startedDate,
      'end_date': endedDate,
      'status': status,
      'is_related': isRelated,
      'has_certificate': hasCertificate,
    };
    await Provider.of<ExternalPassedCoursesProvider>(context, listen: false).addExternalCourse(externalCourseInfo, filePath!);
    Navigator.of(context).pop();
  }
  //------------------- UI ----------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scrollbar(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Form(
              child: _isLoading
                  ? const Center(child: Spinner(size: 25))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: TextInput(label: 'عنوان', keyboardType: TextInputType.text, controller: titleController, onChanged: (value) {}, editable: true)),
                              Expanded(child: TextInput(label: 'نام موسسه', onChanged: (value) {}, controller: instituteController, keyboardType: TextInputType.name)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(child: TextInput(label: 'آدرس', keyboardType: TextInputType.name, controller: addressController, onChanged: (value) {})),
                              Expanded(child: TextInput(label: 'مدت', keyboardType: TextInputType.number, controller: durationController, onChanged: (value) {})),
                            ],
                          ),
                          const SizedBox(height: 10),
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
                                        Text('گواهینامه', style: theme.bodySmall),
                                        CupertinoSwitch(
                                          activeColor: Colors.blue,
                                          value: hasCertificate,
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
                        ],
                      ),
                    ),
            ),
          ),
          Padding(
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
                      onPressed: () => addExternalCourse(),
                      child: const Text('ذخیره'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
