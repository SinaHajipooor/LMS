import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/custom_dropdown.dart';
import 'package:lms/widgets/elements/text_input.dart';
import 'package:lms/widgets/elements/three_line_input.dart';

class CompilationsForm extends StatefulWidget {
  const CompilationsForm({super.key});

  @override
  State<CompilationsForm> createState() => _CompilationsFormState();
}

class _CompilationsFormState extends State<CompilationsForm> {
  bool status = false;
  bool isRelated = false;
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
                  Expanded(child: TextInput(value: title, label: 'عنوان', onChanged: (value) {})),
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
                children: [
                  Expanded(child: TextInput(value: position, label: 'سال انتشار', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(value: title, label: 'محل انتشار', onChanged: (value) {})),
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
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ThreeLineInput(value: description, label: 'توضیحات', onChanged: (value) {}),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
