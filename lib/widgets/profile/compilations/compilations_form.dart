import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/providers/Profile/Compilations/CompilationsProvider.dart';
import 'package:lms/widgets/elements/custom_dropdown.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/elements/text_input.dart';
import 'package:lms/widgets/elements/three_line_input.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class CompilationsForm extends StatefulWidget {
  final bool isEditing;
  final bool isCreating;
  final bool isShowing;
  int? compilationId;
  CompilationsForm({super.key, this.compilationId, required this.isEditing, required this.isCreating, required this.isShowing});

  @override
  State<CompilationsForm> createState() => _CompilationsFormState();
}

class _CompilationsFormState extends State<CompilationsForm> {
// --------------- state -----------------

  TextEditingController titleController = TextEditingController();
  TextEditingController publishPlaceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  String language = '';
  String compilationType = '';
  String status = '0';
  String isRelated = '0';
  File? filePath;
  bool _isLoading = false;
  Map<String, dynamic> compilationDetails = {};
// --------------- lifecycle -----------------
  @override
  void initState() {
    if (widget.isEditing || widget.isShowing) {
      fetchCompilationDetails();
    }
    super.initState();
  }

// --------------- methods -----------------
  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null) {
      setState(() {
        filePath = File(result.files.single.path!);
      });
    }
  }

  Future<void> fetchCompilationDetails() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CompilationsProvider>(context, listen: false).fetchCompilationDetails(widget.compilationId!);
    setState(() {
      compilationDetails = Provider.of<CompilationsProvider>(context, listen: false).compilationDetails;
      titleController.text = compilationDetails['title'] ?? '';
      publishPlaceController.text = compilationDetails['publish_place'] ?? '';
      descriptionController.text = compilationDetails['description'] ?? '';
      language = compilationDetails['language'] ?? '';
      compilationType = compilationDetails['compilation_type'] ?? '';
      status = compilationDetails['status'] == false ? '0' : '1';
      isRelated = compilationDetails['is_related'] == false ? '0' : '1';
      yearController.text = compilationDetails['year'] ?? '';
      _isLoading = false;
    });
  }

  Future<void> addCompilation() async {
    setState(() {
      _isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final compilationInfo = {
      'user_id': userId,
      'title': titleController.text,
      'compilation_type_id': '1',
      'language_id': '1',
      'publish_place': publishPlaceController.text,
      'year': yearController.text,
      'status': status,
      'is_related': isRelated,
      'description': descriptionController.text,
    };

    await Provider.of<CompilationsProvider>(context, listen: false).addCompilation(compilationInfo, filePath!);
    Navigator.of(context).pop();
  }

  Future<void> editCompilation() async {
    setState(() {
      _isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final compilationInfo = {
      'user_id': userId,
      'title': titleController.text,
      'compilation_type_id': '1',
      'language_id': '1',
      'publish_place': publishPlaceController.text,
      'year': yearController.text,
      'status': status,
      'is_related': isRelated,
      'description': descriptionController.text,
    };
    await Provider.of<CompilationsProvider>(context, listen: false).editCompilation(widget.compilationId!, compilationInfo, filePath!);
    Navigator.of(context).pop();
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
                        children: [
                          Row(
                            children: [
                              Expanded(child: TextInput(keyboardType: TextInputType.name, label: 'عنوان', onChanged: (value) {}, controller: titleController)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'نوع اثر')),
                              Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'زبان')),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(child: TextInput(label: 'سال انتشار', onChanged: (value) {}, controller: yearController, keyboardType: TextInputType.number)),
                              Expanded(child: TextInput(label: 'محل انتشار', onChanged: (value) {}, controller: publishPlaceController, keyboardType: TextInputType.name)),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          ThreeLineInput(controller: descriptionController, label: 'توضیحات', onChanged: (value) {}),
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
                          widget.isCreating ? addCompilation() : editCompilation();
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
          ),
        ],
      ),
    );
  }
}
