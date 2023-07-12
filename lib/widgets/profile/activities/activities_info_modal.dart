import 'package:flutter/material.dart';
import 'package:lms/widgets/profile/activities/activites_info_form.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class ActivitiesInfoModal extends StatefulWidget {
  final double deviceHeight;
  // final int selectedIndex;

  const ActivitiesInfoModal({
    required this.deviceHeight,
    // required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ActivitiesInfoModalState createState() => _ActivitiesInfoModalState();
}

class _ActivitiesInfoModalState extends State<ActivitiesInfoModal> {
  final ScrollController _scrollController = ScrollController();

  // ignore: unused_field
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
    final theme = Theme.of(context);
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
            height: widget.deviceHeight * 0.6,
            child: Column(
              children: [
                Container(
                  height: 50, // adjust as needed
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    'ایجاد سوابق  فعالیت‌ها و تجارب',
                    style: theme.textTheme.titleMedium!.apply(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                const Expanded(child: ActivitiesInfoForm()),
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
