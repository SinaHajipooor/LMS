import 'package:flutter/material.dart';
import '../../widgets/profile/user_information_card.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../widgets/profile/user_birth_certificate_form.dart';
import '../../widgets/profile/user_job_info.dart';
import '../../widgets/profile/user_education_info.dart';
import '../../widgets/profile/job_info_form.dart';
import '../../widgets/profile/education_info_form.dart';

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
  final _scrollController = ScrollController();

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

  void _showJobinfoFormModal(BuildContext context, double deviceHeight, int selectedIndex) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        final keyboardOffset = MediaQuery.of(context).viewInsets.bottom;

        return StatefulBuilder(
          builder: (context, setState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Scroll the modal to the top when the keyboard is open
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
              child: Container(
                height: deviceHeight * 0.7,
                child: Column(
                  children: [
                    Container(
                      height: 50, // adjust as needed
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      child: Text(selectedIndex == 2 ? 'ایجاد اطلاعات شغلی' : 'ایجاد اطلاعات تحصیلی', style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: JobInfoForm(
                        selectDate: _selectDate,
                        startEmployeeTime: startEmployeeTime,
                        endEmployeeTime: endEmployeeTime,
                        birthDate: _birthDate,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
                    visible: _selectedIndex == 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          ElevatedButton.icon(
                              onPressed: () => _showJobinfoFormModal(
                                    context,
                                    deviceSize.height,
                                    _selectedIndex,
                                  ),
                              icon: const Icon(Icons.add, size: 15),
                              label: const Text('ایجاد', style: TextStyle(fontSize: 13))),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _selectedIndex == 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {
                                _showJobinfoFormModal(context, deviceSize.height, _selectedIndex);
                              },
                              icon: const Icon(Icons.add, size: 15),
                              label: const Text('ایجاد', style: TextStyle(fontSize: 13))),
                        ],
                      ),
                    ),
                  ),
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
