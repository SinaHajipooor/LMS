import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../elements/text_input.dart';
import '../elements/custom_dropdown.dart';

class UserBirthCertificateScreen extends StatefulWidget {
// --------------- feilds -----------------
  static const routeName = '/user-birth-certificate-screen';

  const UserBirthCertificateScreen({super.key});

  @override
  State<UserBirthCertificateScreen> createState() => _UserBirthCertificateScreenState();
}

class _UserBirthCertificateScreenState extends State<UserBirthCertificateScreen> {
  // String? _birthDate;
  // String? startEmployeeTime;
  // String? endEmployeeTime;
  Future<void> _selectDate(BuildContext context) async {
    final Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1300, 1, 1),
      lastDate: Jalali.now(),
      locale: const Locale('fa'),
    );

    if (picked != null) {
      // ignore: unused_local_variable
      final String formattedDate = picked.toJalaliDateTime().substring(0, 10);
      setState(() {
        // _birthDate = formattedDate;
      });
    }
  }

// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text('اطلاعات شناسنامه‌ای', style: TextStyle(color: Colors.black, fontSize: 15)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'جنسیت')),
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'دین')),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'شهرمحل تولد')),
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'وضعیت پایان خدمت')),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'شهر صادرکننده')),
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'شهر')),
              ],
            ),
            const SizedBox(height: 17),
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
                        _selectDate(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.calendar_today, size: 20),
                            SizedBox(width: 16),
                            Text(
                              'تاریخ شروع استخدام',
                              style: TextStyle(fontSize: 11),
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
                        child: const Row(
                          children: [
                            Icon(Icons.calendar_today, size: 20),
                            SizedBox(width: 16),
                            Text(
                              'تاریخ پایان استخدام',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'آخرین شغل')),
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'وضعیت استخدام')),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'آخرین مدرک آموزشی')),
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
                        child: const Row(
                          children: [
                            Icon(Icons.calendar_today, size: 20),
                            SizedBox(width: 16),
                            Text(
                              'تاریخ تولد!',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                Expanded(child: TextInput(value: '', label: 'نام لاتین', onChanged: (value) {})),
                Expanded(child: TextInput(value: '', label: 'تلفن محل‌کار', onChanged: (value) {}, keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                Expanded(child: TextInput(value: '', label: 'شماره شناسنامه', onChanged: (value) {}, keyboardType: TextInputType.number)),
                Expanded(child: TextInput(value: '', label: 'نام پدر', onChanged: (value) {})),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                Expanded(child: TextInput(value: '', label: 'سری شناسنامه', onChanged: (value) {})),
                Expanded(child: TextInput(value: '', label: 'سریال‌شناسنامه', onChanged: (value) {})),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                Expanded(child: TextInput(value: '', label: 'شماره‌شبا', onChanged: (value) {}, keyboardType: TextInputType.number)),
                Expanded(child: TextInput(value: '', label: 'کد‌پستی', onChanged: (value) {}, keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                Expanded(child: TextInput(value: '', label: 'آدرس', onChanged: (value) {})),
                Expanded(child: TextInput(value: '', label: 'تلفن', onChanged: (value) {}, keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 17),
            SizedBox(
              height: 52,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red[400]!),
                      ),
                      child: const Text('انصراف'),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: const Text('ثبت'),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
