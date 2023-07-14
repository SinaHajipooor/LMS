import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/providers/Profile/ActivityHistory/ActivityHistoryProvider.dart';
import 'package:lms/widgets/elements/custom_dropdown.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/elements/three_line_input.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import '../../elements/text_input.dart';

// ignore: must_be_immutable
class ActivitiesInfoForm extends StatefulWidget {
  final bool isCreating;
  final bool isEditing;
  final bool isShowing;
  int? activityId;
  ActivitiesInfoForm({
    super.key,
    required this.isCreating,
    required this.isEditing,
    required this.isShowing,
    this.activityId,
  });

  @override
  State<ActivitiesInfoForm> createState() => _ActivitiesInfoFormState();
}

class _ActivitiesInfoFormState extends State<ActivitiesInfoForm> {
// --------------- state -----------------
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Map<String, dynamic> activityDetails = {};
  String startedDate = '';
  String endedDate = '';
  File? filePath;
  String status = '0';
  String isRelated = '0';
  String isCurrentPostion = '0';
  String workType = '';
  bool _isLoading = false;

// --------------- lifecycle -----------------

  @override
  void initState() {
    if (widget.isEditing || widget.isShowing) {
      fetchActivityDetails();
    }
    super.initState();
  }

// --------------- methods -----------------
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

  Future<void> fetchActivityDetails() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<ActivityHistoryProvider>(context, listen: false).fetchActivityDetails(widget.activityId!);
    setState(() {
      activityDetails = Provider.of<ActivityHistoryProvider>(context, listen: false).activityDetails;
      titleController.text = activityDetails['title'] ?? '';
      descriptionController.text = activityDetails['description'] ?? '';
      addressController.text = activityDetails['address'] ?? '';
      positionController.text = activityDetails['position'] ?? '';
      startedDate = activityDetails['start_date'].replaceAll('/', '-');
      endedDate = activityDetails['end_date'].replaceAll('/', '-');
      isRelated = activityDetails['is_related'] == false ? '0' : '1';
      isCurrentPostion = activityDetails['current_position'] == false ? '0' : '1';
      status = activityDetails['status'] == false ? '0' : '1';
      workType = activityDetails['work_type'] ?? 'تمام وقت';
      _isLoading = false;
    });
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

// --------------- UI -----------------
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
                            Expanded(child: TextInput(controller: titleController, label: 'عنوان', onChanged: (value) {}, keyboardType: TextInputType.number)),
                            Expanded(child: TextInput(controller: addressController, label: 'آدرس', onChanged: (value) {}, keyboardType: TextInputType.number)),
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
                            Expanded(child: TextInput(controller: positionController, label: 'سمت', onChanged: (value) {}, keyboardType: TextInputType.number)),
                            Expanded(
                              child: CustomDropdown(
                                placeholder: 'نوع همکاری',
                                items: const ['تمام وقت', 'پاره وقت'],
                                onChanged: (value) {
                                  setState(() {
                                    workType = value;
                                  });
                                },
                              ),
                            )
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
                                      Text('فعالیت جاری', style: theme.bodySmall),
                                      CupertinoSwitch(
                                        activeColor: Colors.blue,
                                        value: isCurrentPostion == '0' ? false : true,
                                        onChanged: (bool value) {
                                          setState(() {
                                            isCurrentPostion = value == false ? '0' : '1';
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
                        ThreeLineInput(
                          label: 'توضیحات',
                          onChanged: (value) {},
                          controller: descriptionController,
                        ),
                        const SizedBox(height: 15)
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
                      onPressed: () {},
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
