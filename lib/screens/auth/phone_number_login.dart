import 'package:flutter/material.dart';
import 'package:lms/providers/Auth/AuthProvider.dart';
import 'package:lms/screens/auth/otp_login.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:provider/provider.dart';

class PhoneNumberLogin extends StatefulWidget {
  const PhoneNumberLogin({super.key});

  @override
  State<PhoneNumberLogin> createState() => _PhoneNumberLoginState();
}

class _PhoneNumberLoginState extends State<PhoneNumberLogin> {
//------------------------ state ----------------------
  final _formKey = GlobalKey<FormState>();

  // 0 for phone number login and 1 for otp login
  PageController _pageController = PageController(initialPage: 0);
  bool _isLoading = false;
  String? _mobile;
//------------------------ methods ----------------------
  Future<void> mobileLoginHandler() async {
    if (_mobile != '') {
      setState(() {
        _isLoading = true;
      });
      final userMobile = _mobile.toString();
      await Provider.of<AuthProvider>(context, listen: false).mobileLogin(userMobile);
    }
    setState(() {
      _isLoading = false;
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

//------------------------ UI ----------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 38, 32, 32),
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _isLoading
              ? const Center(child: Spinner(size: 20))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('به سیستم یادگیری الکترونیک خوش آمدید', style: theme.bodyLarge),
                      const SizedBox(height: 8),
                      Text(
                        'لطفا شماره موبایل خود را وارد کنید',
                        style: theme.bodySmall!.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 58),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          style: theme.bodyMedium!.copyWith(fontSize: 18),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'از صحت شماره‌موبایل خود مطمئن شوید';
                            }
                            setState(() {
                              _mobile = value;
                            });
                            return null;
                          },
                          onSaved: (String? value) {
                            _mobile = value;
                          },
                          decoration: const InputDecoration(
                            label: Text(
                              'شماره موبایل',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 58),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            mobileLoginHandler();
                          }
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width, 60),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        child: const Text('دریافت کد', style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
          _isLoading
              ? const Center(
                  child: Spinner(size: 20),
                )
              : OtpLogin(
                  mobileNumber: _mobile ?? '',
                ),
        ],
      ),
    );
  }
}
