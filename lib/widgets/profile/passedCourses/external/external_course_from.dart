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

// ignore: must_be_immutable
class ExternalCourseForm extends StatefulWidget {
  final bool isEditing;
  final bool isCreating;
  final bool isShowing;
  int? externalCourseId;
  ExternalCourseForm({
    super.key,
    this.externalCourseId,
    required this.isEditing,
    required this.isCreating,
    required this.isShowing,
  });

  @override
  State<ExternalCourseForm> createState() => _ExternalCourseFormState();
}

class _ExternalCourseFormState extends State<ExternalCourseForm> {
  //------------------- state ----------------------
  Map<String, dynamic> externalCourseDetails = {};
  final TextEditingController titleController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  String startedDate = '';
  String endedDate = '';
  String isRelated = '0';
  String hasCertificate = '0';
  String status = '0';
  File? filePath;
  bool _isLoading = false;
  //------------------- lifecycle ----------------------

  @override
  void initState() {
    if (widget.isEditing || widget.isShowing) {
      fetchExternalCourseInfo();
    }
    super.initState();
  }
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

  Future<void> fetchExternalCourseInfo() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<ExternalPassedCoursesProvider>(context, listen: false).fetchExternalCourseDetails(widget.externalCourseId!);
    setState(() {
      externalCourseDetails = Provider.of<ExternalPassedCoursesProvider>(context, listen: false).externalCourseDetails;
      titleController.text = externalCourseDetails['title'];
      instituteController.text = externalCourseDetails['institute_title'];
      addressController.text = externalCourseDetails['address'];
      durationController.text = externalCourseDetails['duration'];
      startedDate = externalCourseDetails['start_date'].replaceAll('/', '-');
      endedDate = externalCourseDetails['end_date'].replaceAll('/', '-');
      isRelated = externalCourseDetails['is_related'];
      status = externalCourseDetails['status'];
      hasCertificate = externalCourseDetails['has_certificate'];
      _isLoading = false;
    });
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

  Future<void> editExternalCourse() async {
    print('... editing');
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

    await Provider.of<ExternalPassedCoursesProvider>(context, listen: false).editExternalCourse(widget.externalCourseId!, externalCourseInfo, filePath!);
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
                      physics: const BouncingScrollPhysics(),
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
                                        Text('گواهینامه', style: theme.bodySmall),
                                        CupertinoSwitch(
                                          activeColor: Colors.blue,
                                          value: hasCertificate == '0' ? false : true,
                                          onChanged: (bool value) {
                                            setState(() {
                                              hasCertificate = value == false ? '0' : '1';
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
                          widget.isCreating ? addExternalCourse() : editExternalCourse();
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
      ),
    );
  }
}
