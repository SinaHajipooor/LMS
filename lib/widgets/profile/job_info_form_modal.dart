import 'package:flutter/material.dart';
import 'package:lms/widgets/profile/education_info_form.dart';
import 'package:lms/widgets/profile/job_info_form.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class JobInfoFormModal extends StatefulWidget {
  final double deviceHeight;
  final int selectedIndex;

  const JobInfoFormModal({
    required this.deviceHeight,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  _JobInfoFormModalState createState() => _JobInfoFormModalState();
}

class _JobInfoFormModalState extends State<JobInfoFormModal> {
  ScrollController _scrollController = ScrollController();

  String _birthDate = 'تاریخ تولد';
  String startEmployeeTime = 'زمان استخدام';
  String endEmployeeTime = 'زمان پایان استخدام';

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
        _birthDate = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOffset = MediaQuery.of(context).viewInsets.bottom;

    return StatefulBuilder(
      builder: (context, setState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (keyboardOffset > 0) {
            setState(() {
              _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
              );
            });
          }
        });
        return SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(
            bottom: keyboardOffset + MediaQuery.of(context).padding.bottom,
          ),
          child: SizedBox(
            height: widget.selectedIndex == 2 ? widget.deviceHeight * 0.65 : widget.deviceHeight * 0.5,
            child: Column(
              children: [
                Container(
                  height: 50, // adjust as needed
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    widget.selectedIndex == 2 ? 'ایجاد اطلاعات شغلی' : 'ایجاد اطلاعات تحصیلی',
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: widget.selectedIndex == 2
                      ? JobInfoForm(
                          selectDate: _selectDate,
                          startEmployeeTime: startEmployeeTime,
                          endEmployeeTime: endEmployeeTime,
                          birthDate: _birthDate,
                        )
                      : EducationInfoForm(
                          selectDate: _selectDate,
                          birthDate: _birthDate,
                          startEmployeeTime: startEmployeeTime,
                          endEmployeeTime: endEmployeeTime,
                        ),
                ),
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
                          child: const Text('انصراف'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('ذخیره'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
