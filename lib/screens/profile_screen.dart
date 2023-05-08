import 'package:flutter/material.dart';
import '../widgets/profile/user_information_card.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../widgets/profile/user_birth_certificate_form.dart';
import '../widgets/profile/user_job_info.dart';
import '../widgets/profile/user_education_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ------------- state ---------------
  String _birthDate = 'تاریخ تولد';
  String startEmployeeTime = 'زمان استخدام';
  String endEmployeeTime = 'زمان پایان استخدام';
  List<String> dropdownValues = List.generate(14, (index) => "Option ${index + 1}");
  List<TextEditingController> inputControllers = List.generate(10, (index) => TextEditingController());
  int _selectedIndex = 1;

// ------------- lifecycle -------------
  @override
  void dispose() {
    inputControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
// ------------- method -------------

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

  void _onSelectInfo(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        automaticallyImplyLeading: false,
        title: const Text('اطلاعات کاربری', style: TextStyle(color: Colors.black, fontSize: 13)),
        actions: [
          TextButton(onPressed: () {}, child: const Text('ذخیره تغییرات', style: TextStyle(fontSize: 12))),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInformationCard(onSelect: _onSelectInfo, selectedIndex: _selectedIndex),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Visibility(
                    visible: _selectedIndex == 1,
                    child: UserBirthCertificateForm(
                      birthDate: _birthDate,
                      selectDate: _selectDate,
                      startEmployeeTime: startEmployeeTime,
                      endEmployeeTime: endEmployeeTime,
                    ),
                  ),
                  Visibility(
                    visible: _selectedIndex == 2,
                    child: UserJobInfo(),
                  ),
                  Visibility(visible: _selectedIndex == 3, child: const UserEducationInfo())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
