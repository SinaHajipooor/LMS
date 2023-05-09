import 'package:flutter/material.dart';
import '../elements/text_input.dart';
import '../elements/custom_dropdown.dart';

class EducationInfoForm extends StatelessWidget {
// ---------------- feilds ---------------
  String? birthDate;
  String? startEmployeeTime;
  String? endEmployeeTime;
  Future<void> Function(BuildContext) selectDate;
  EducationInfoForm({super.key, this.birthDate, required this.selectDate, this.startEmployeeTime, this.endEmployeeTime});
// ---------------- UI ---------------
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            // const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'مدرک تحصیلی')),
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'رشته تحصیلی')),
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
                              style: TextStyle(fontSize: startEmployeeTime != 'تاریخ شروع مدرک' ? 13 : 11),
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
                              style: TextStyle(fontSize: endEmployeeTime != 'تاریخ اخذ مدرک' ? 13 : 11),
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
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'نوع دانشگاه مدرک')),
                Expanded(child: TextInput(value: '', placeholder: 'دانشگاه اخذ مدرک', onChanged: (value) {}, keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: TextInput(value: '', placeholder: ' معدل', onChanged: (value) {}, keyboardType: TextInputType.number)),
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'رشته شغلی')),
              ],
            ),
            const SizedBox(height: 15),
            Row(
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
                      child: const Text('انصراف')),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('ذخیره'),
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
