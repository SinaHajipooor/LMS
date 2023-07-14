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
  TextEditingController titleController = TextEditingController();

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
                  Expanded(child: TextInput(controller: titleController, label: 'نوع برگزاری', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(controller: titleController, label: 'ماهیت جلسه', onChanged: (value) {}, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: TextInput(controller: titleController, label: 'مدرس جلسه', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(controller: titleController, label: 'ناظر جلسه', onChanged: (value) {}, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: TextInput(controller: titleController, label: 'زمان شروع', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(controller: titleController, label: 'زمان پایان', onChanged: (value) {}, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: TextInput(controller: titleController, label: 'آدرس یا لینک', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(controller: titleController, label: 'تلفن هماهنگی', onChanged: (value) {}, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 15),
              ThreeLineInput(controller: titleController, label: 'توضیحات', onChanged: (value) {}),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
