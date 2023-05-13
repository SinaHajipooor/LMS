import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/screens/landing_screen.dart';
import '../../widgets/profile/user_information_card.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../widgets/profile/user_birth_certificate_form.dart';
import '../../widgets/profile/user_job_info.dart';
import '../../widgets/profile/user_education_info.dart';
import '../../widgets/profile/job_info_form.dart';
import '../../widgets/profile/education_info_form.dart';
import '../../widgets/elements/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
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
  bool _isFabVisible = true;
// ------------- lifecycle -------------
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _isFabVisible = false;
        });
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _isFabVisible = true;
        });
      }
    });
  }

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
    ScrollController _scrollController = ScrollController();
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

        _scrollController = ScrollController();

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
              child: Container(
                height: selectedIndex == 2 ? deviceHeight * 0.6 : deviceHeight * 0.50,
                child: Column(
                  children: [
                    Container(
                      height: 50, // adjust as needed
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      child: Text(
                        selectedIndex == 2 ? 'ایجاد اطلاعات شغلی' : 'ایجاد اطلاعات تحصیلی',
                        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: selectedIndex == 2
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                const CustomAppbar(title: 'اطلاعات کاربری'),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: deviceSize.height / 2.5,
                            child: UserInformationCard(onSelect: _onSelectInfo, selectedIndex: _selectedIndex),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                              ),
                            ),
                            child: Column(
                              children: [
                                AnimatedOpacity(
                                  opacity: _selectedIndex == 2 ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 700),
                                  curve: Curves.easeInOut,
                                  child: Visibility(
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
                                            label: const Text('ایجاد', style: TextStyle(fontSize: 13)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                AnimatedOpacity(
                                  opacity: _selectedIndex == 3 ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 700),
                                  curve: Curves.easeInOut,
                                  child: Visibility(
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
                                            label: const Text('ایجاد', style: TextStyle(fontSize: 13)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                AnimatedOpacity(
                                  opacity: _selectedIndex == 1 ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 700),
                                  curve: Curves.easeInOut,
                                  child: Visibility(
                                    visible: _selectedIndex == 1,
                                    child: UserBirthCertificateForm(
                                      birthDate: _birthDate,
                                      selectDate: _selectDate,
                                      startEmployeeTime: startEmployeeTime,
                                      endEmployeeTime: endEmployeeTime,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Stack(
                children: [
                  AnimatedOpacity(
                    opacity: _selectedIndex == 2 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                    child: Visibility(
                      visible: _selectedIndex == 2,
                      child: UserJobInfo(),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _selectedIndex == 3 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                    child: Visibility(visible: _selectedIndex == 3, child: const UserEducationInfo()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
