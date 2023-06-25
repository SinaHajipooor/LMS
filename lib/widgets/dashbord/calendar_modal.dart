import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/text_input.dart';
import 'package:lms/widgets/elements/three_line_input.dart';

class CalendarModal extends StatefulWidget {
  const CalendarModal({super.key});

  @override
  State<CalendarModal> createState() => _CalendarModalState();
}

class _CalendarModalState extends State<CalendarModal> {
  //---------------- state -------------------
  Map<String, String> inputValues = {};
  //---------------- UI -------------------

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: TextInput(value: '', label: 'نوع برگزاری', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(value: '', label: 'ماهیت جلسه', onChanged: (value) {}, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: TextInput(value: '', label: 'مدرس جلسه', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(value: '', label: 'ناظر جلسه', onChanged: (value) {}, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: TextInput(value: '', label: 'زمان شروع', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(value: '', label: 'زمان پایان', onChanged: (value) {}, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: TextInput(value: '', label: 'آدرس یا لینک', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(value: '', label: 'تلفن هماهنگی', onChanged: (value) {}, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 15),
              ThreeLineInput(value: 'سلام این پیام برای تست فیلد توضیحات در این ویجت می باشدسلام این پیام برای تست فیلد توضیحات در این ویجت می باشدسلام این پیام برای تست فیلد توضیحات در این ویجت می باشدسلام این پیام برای تست ف ویجت می باشد', label: 'توضیحات', onChanged: (value) {}),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
