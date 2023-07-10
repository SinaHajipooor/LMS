import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/three_line_input.dart';

class StudentFilesForm extends StatefulWidget {
  const StudentFilesForm({super.key});

  @override
  State<StudentFilesForm> createState() => _StudentFilesFormState();
}

class _StudentFilesFormState extends State<StudentFilesForm> {
  // ------------------- state --------------------

  File? _selectedFile;

  // ------------------- methods --------------------
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          'فایل مورد نظر را بارگذاری کنید',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(right: 5, left: 5),
          child: SizedBox(
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
                          _selectedFile != null ? 'فایل انتخاب شد' : 'فایل',
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
        ),
        const SizedBox(height: 5),
        ThreeLineInput(value: '', label: 'توضیحات', onChanged: (value) {}),
        const SizedBox(height: 5),
      ],
    );
  }
}
