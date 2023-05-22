import 'package:flutter/material.dart';
import '../elements/text_input.dart';
import '../elements/custom_dropdown.dart';

// ignore: must_be_immutable
class UserBirthCertificateForm extends StatelessWidget {
// --------------- feilds -----------------
  String? birthDate;
  String? startEmployeeTime;
  String? endEmployeeTime;
  Future<void> Function(BuildContext) selectDate;
  UserBirthCertificateForm({super.key, this.birthDate, required this.selectDate, this.startEmployeeTime, this.endEmployeeTime});
// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'جنسیت')),
            Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'دین')),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'شهرمحل تولد')),
            Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'وضعیت پایان خدمت')),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'شهر صادرکننده')),
            Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'شهر')),
          ],
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'آخرین شغل')),
            Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'وضعیت استخدام')),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'آخرین مدرک آموزشی')),
            Expanded(child: TextInput(value: '', placeholder: 'تلفن', onChanged: (value) {}, keyboardType: TextInputType.number)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: TextInput(value: '', placeholder: 'نام لاتین', onChanged: (value) {})),
            Expanded(child: TextInput(value: '', placeholder: 'تلفن محل‌کار', onChanged: (value) {}, keyboardType: TextInputType.number)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: TextInput(value: '', placeholder: 'شماره شناسنامه', onChanged: (value) {}, keyboardType: TextInputType.number)),
            Expanded(child: TextInput(value: '', placeholder: 'نام پدر', onChanged: (value) {})),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: TextInput(value: '', placeholder: 'سری شناسنامه', onChanged: (value) {})),
            Expanded(child: TextInput(value: '', placeholder: 'سریال‌شناسنامه', onChanged: (value) {})),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: TextInput(value: '', placeholder: 'شماره‌شبا', onChanged: (value) {}, keyboardType: TextInputType.number)),
            Expanded(child: TextInput(value: '', placeholder: 'کد‌پستی', onChanged: (value) {}, keyboardType: TextInputType.number)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: TextInput(value: '', placeholder: 'آدرس', onChanged: (value) {})),
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
                          birthDate!,
                          style: TextStyle(fontSize: birthDate != 'تاریخ تولد' ? 13 : 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
