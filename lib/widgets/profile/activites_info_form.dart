import 'package:flutter/material.dart';
import '../../widgets/elements/text_input.dart';
import '../../widgets/elements/custom_dropdown.dart';

// ignore: must_be_immutable
class ActivitiesInfoForm extends StatelessWidget {
  String? birthDate;
  String? startEmployeeTime;
  String? endEmployeeTime;
  Future<void> Function(BuildContext) selectDate;
  ActivitiesInfoForm({super.key, this.birthDate, required this.selectDate, this.startEmployeeTime, this.endEmployeeTime});

// --------------- UI -----------------
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
                  Expanded(child: TextInput(value: '', label: 'عنوان', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(value: '', label: 'آدرس', onChanged: (value) {}, keyboardType: TextInputType.number)),
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
                          selectDate(context);
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
                                startEmployeeTime!,
                                style: TextStyle(fontSize: startEmployeeTime != 'تاریخ شروع' ? 13 : 11),
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
                          selectDate(context);
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
                                endEmployeeTime!,
                                style: TextStyle(fontSize: endEmployeeTime != 'تاریخ پایان ' ? 13 : 11),
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
                  Expanded(child: TextInput(value: '', label: 'سمت', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(value: '', label: 'فعالیت جاری', onChanged: (value) {}, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'توضیحات')),
                  Expanded(child: TextInput(value: '', label: 'فایل ضمیمه', onChanged: (value) {}, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'وضعیت')),
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'فعالیت مرتبط')),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
