import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/navigation/bottom_tabas.dart';
import 'package:lms/widgets/profile/job_info_form_modal.dart';
import '../../widgets/profile/user_information_card.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../widgets/profile/user_job_info.dart';
import '../../widgets/profile/user_education_info.dart';

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
  // ignore: unused_field
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

  _showJobinfoFormModal(BuildContext context, double deviceHeight, int selectedIndex) {
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
        return UserInfoFormModal(deviceHeight: deviceHeight, selectedIndex: selectedIndex);
      },
    );
  }

// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BottomTabs(defaultPageIndex: 2)));
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  title: const Text('اطلاعات کاربری', style: TextStyle(fontSize: 13, color: Colors.black)),
                  backgroundColor: Colors.white,
                  titleSpacing: 32,
                  actions: [
                    TextButton.icon(
                      onPressed: () {},
                      label: const Text('ذخیره تغییرات', style: TextStyle(fontSize: 13)),
                      icon: const Icon(Icons.save_alt_outlined, size: 17),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: deviceSize.height / 2.2,
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // AnimatedOpacity(
                                //   opacity: _selectedIndex == 1 ? 1.0 : 0.0,
                                //   duration: const Duration(milliseconds: 700),
                                //   curve: Curves.easeInOut,
                                //   child: Visibility(
                                //     visible: _selectedIndex == 1,
                                //     child: UserBirthCertificateForm(
                                //       birthDate: _birthDate,
                                //       selectDate: _selectDate,
                                //       startEmployeeTime: startEmployeeTime,
                                //       endEmployeeTime: endEmployeeTime,
                                //     ),
                                //   ),
                                // ),
                                AnimatedOpacity(
                                  opacity: _selectedIndex == 2 ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 700),
                                  curve: Curves.easeInOut,
                                  child: Visibility(
                                    visible: _selectedIndex == 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: ElevatedButton.icon(
                                              onPressed: () => _showJobinfoFormModal(
                                                context,
                                                deviceSize.height,
                                                _selectedIndex,
                                              ),
                                              icon: const Icon(Icons.add, size: 15),
                                              label: const Text('ایجاد', style: TextStyle(fontSize: 13)),
                                            ),
                                          ),
                                          const UserJobInfo(),
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
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              _showJobinfoFormModal(context, deviceSize.height, _selectedIndex);
                                            },
                                            icon: const Icon(Icons.add, size: 15),
                                            label: const Text('ایجاد', style: TextStyle(fontSize: 13)),
                                          ),
                                        ),
                                        const UserEducationInfo(),
                                      ],
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
          ],
        ),
      ),
    );
  }
}
