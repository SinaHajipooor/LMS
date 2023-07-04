import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class BankPaymentApproach extends StatefulWidget {
  const BankPaymentApproach({super.key});

  // ------------------- feilds --------------------
  @override
  State<BankPaymentApproach> createState() => _BankPaymentApproachState();
}

class _BankPaymentApproachState extends State<BankPaymentApproach> {
  // ------------------- state --------------------
  final TextEditingController _textEditingController = TextEditingController();
  File? _selectedFile;
  String? _selectedDate;

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

  Future<void> _selectDate(BuildContext context) async {
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
        _selectedDate = formattedDate;
      });
    }
  }

  // ------------------- UI --------------------
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 5),
            child: Row(
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
                                _selectedFile != null ? 'فایل انتخاب شد' : 'فایل سند',
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
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 1,
                    child: InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 16),
                            Text(
                              _selectedDate != null ? _selectedDate! : 'زمان سند را وارد کنید',
                              style: TextStyle(fontSize: _selectedDate != null ? 13 : 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(right: 5, left: 5),
            child: SizedBox(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 1,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    labelText: 'کد پیگیری را وارد کنید',
                    labelStyle: TextStyle(fontSize: 12),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      );
    });
  }
}
