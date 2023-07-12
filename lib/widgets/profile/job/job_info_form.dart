import 'package:flutter/material.dart';
import '../../elements/text_input.dart';
import '../../elements/custom_dropdown.dart';

// ignore: must_be_immutable
class JobInfoForm extends StatelessWidget {
  String? birthDate;
  String? startEmployeeTime;
  String? endEmployeeTime;
  Future<void> Function(BuildContext) selectDate;
  JobInfoForm({super.key, this.birthDate, required this.selectDate, this.startEmployeeTime, this.endEmployeeTime});

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
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'دستگاه اجرایی')),
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'وضعیت اشتغال')),
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
                                style: TextStyle(fontSize: startEmployeeTime != 'زمان استخدام' ? 13 : 11),
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
                                style: TextStyle(fontSize: endEmployeeTime != 'زمان پایان استخدام' ? 13 : 11),
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
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'نوع استخدام')),
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'شهر محل خدمت')),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'رده مدیریتی')),
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'رشته شغلی')),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'رسته شغلی')),
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'رتبه شغلی')),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'رتبه علمی')),
                  Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'پست سازمانی')),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: TextInput(value: '', label: 'تلفن محل‌کار', onChanged: (value) {}, keyboardType: TextInputType.number)),
                  Expanded(child: TextInput(value: '', label: 'شماره پرسنلی', onChanged: (value) {}, keyboardType: TextInputType.number)),
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
