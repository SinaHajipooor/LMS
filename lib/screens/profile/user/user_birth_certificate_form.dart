import 'package:flutter/material.dart';
import 'package:lms/helpers/internet_connectivity_helper.dart';
import 'package:lms/providers/Profile/Identity/IdentityProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:provider/provider.dart';
import '../../../widgets/elements/text_input.dart';
import '../../../widgets/elements/custom_dropdown.dart';

class UserBirthCertificateScreen extends StatefulWidget {
// --------------- feilds -----------------
  static const routeName = '/user-birth-certificate-screen';

  const UserBirthCertificateScreen({super.key});

  @override
  State<UserBirthCertificateScreen> createState() => _UserBirthCertificateScreenState();
}

class _UserBirthCertificateScreenState extends State<UserBirthCertificateScreen> {
// --------------- state -----------------
  TextEditingController titleController = TextEditingController();
  TextEditingController latinNameController = TextEditingController();
  TextEditingController officePhoneController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController seriNumberController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController shabaNumberController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController homePhoneController = TextEditingController();

  String startEmployeeDate = '';
  String endEmployeeDate = '';
  String birthDate = '';
  bool _isLoading = true;
  Map<String, dynamic> userIdentityInfo = {};
// --------------- lifecycle -----------------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    fetchAllUserIdentityInfo();
    super.initState();
  }

  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

// --------------- methods -----------------

  Future<void> fetchAllUserIdentityInfo() async {
    setState(() {
      userIdentityInfo = Provider.of<IdentityProvider>(context, listen: false).identityInfo;
      _isLoading = false;
    });
  }

// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text('اطلاعات شناسنامه‌ای', style: theme.textTheme.titleMedium),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.iconTheme!.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: Spinner(size: 35))
          : SingleChildScrollView(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                'تاریخ شروع',
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 1,
                              child: InkWell(
                                onTap: () {
                                  // _selectStartedDate(context);
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
                                        startEmployeeDate,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text('تاریخ پایان', style: theme.textTheme.bodySmall),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 1,
                              child: InkWell(
                                onTap: () {
                                  // _selectEndedDate(context);
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
                                        endEmployeeDate,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: CustomDropdown(items: const ['one', 'two', 'three'], onChanged: (value) {}, placeholder: 'آخرین مدرک آموزشی')),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text('تاریخ تولد', style: theme.textTheme.bodySmall),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 1,
                              child: InkWell(
                                onTap: () {
                                  // _selectEndedDate(context);
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
                                        endEmployeeDate,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),
                  Row(
                    children: [
                      Expanded(child: TextInput(controller: latinNameController, keyboardType: TextInputType.name, label: 'نام لاتین', onChanged: (value) {})),
                      Expanded(child: TextInput(controller: officePhoneController, label: 'تلفن محل‌کار', onChanged: (value) {}, keyboardType: TextInputType.number)),
                    ],
                  ),
                  const SizedBox(height: 17),
                  Row(
                    children: [
                      Expanded(child: TextInput(controller: identityNumberController, label: 'شماره شناسنامه', onChanged: (value) {}, keyboardType: TextInputType.number)),
                      Expanded(child: TextInput(controller: fatherNameController, keyboardType: TextInputType.name, label: 'نام پدر', onChanged: (value) {})),
                    ],
                  ),
                  const SizedBox(height: 17),
                  Row(
                    children: [
                      Expanded(child: TextInput(controller: seriNumberController, keyboardType: TextInputType.name, label: 'سری شناسنامه', onChanged: (value) {})),
                      Expanded(child: TextInput(controller: serialNumberController, keyboardType: TextInputType.name, label: 'سریال‌شناسنامه', onChanged: (value) {})),
                    ],
                  ),
                  const SizedBox(height: 17),
                  Row(
                    children: [
                      Expanded(child: TextInput(controller: shabaNumberController, label: 'شماره‌شبا', onChanged: (value) {}, keyboardType: TextInputType.number)),
                      Expanded(child: TextInput(controller: postalCodeController, label: 'کد‌پستی', onChanged: (value) {}, keyboardType: TextInputType.number)),
                    ],
                  ),
                  const SizedBox(height: 17),
                  Row(
                    children: [
                      Expanded(child: TextInput(controller: addressController, keyboardType: TextInputType.name, label: 'آدرس', onChanged: (value) {})),
                      Expanded(child: TextInput(controller: homePhoneController, label: 'تلفن', onChanged: (value) {}, keyboardType: TextInputType.number)),
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
