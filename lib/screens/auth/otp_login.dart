import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/providers/Auth/AuthProvider.dart';
import 'package:lms/screens/root/home_screen.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OtpLogin extends StatefulWidget {
  String mobileNumber = '';
  OtpLogin({super.key, required this.mobileNumber});

  @override
  State<OtpLogin> createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  // --------------- state ----------------
  // OtpFieldController otpFieldController = OtpFieldController();
  final TextEditingController pinEditingController = TextEditingController();
  Timer? _timer;
  int _startSeconds = 90;
  int _elapsedSeconds = 0;
  bool _isLoading = false;
  String _otpCode = '';
  // --------------- lifecycle ----------------
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  // --------------- methods ----------------
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_startSeconds <= 0) {
          _timer!.cancel();
        } else {
          _startSeconds = _startSeconds - 1;
          _elapsedSeconds = _elapsedSeconds + 1;
        }
      });
    });
  }

  Future<void> mobileConfirmLogin() async {
    setState(() => _isLoading = true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.mobileConfirmLogin(_otpCode).then((_) {
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }).catchError((error) {
      // Handle error
    }).whenComplete(() {
      setState(() => _isLoading = false);
    });
  }

  // --------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final themeMode = Provider.of<ThemeModel>(context).themeMode;
    final remainingDuration = Duration(seconds: _startSeconds);
    final remaining = '${remainingDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    final PinDecoration pinDecoration = BoxLooseDecoration(
      strokeColorBuilder: PinListenColorBuilder(Colors.grey.shade600.withOpacity(0.2), Colors.grey.shade300),
      radius: const Radius.circular(10),
      textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: themeMode == ThemeMode.light ? Colors.black : Colors.grey),
      obscureStyle: ObscureStyle(
        isTextObscure: false,
        obscureText: '●',
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: _isLoading
          ? const Center(child: Spinner(size: 20))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('به سیستم یادگیری الکترونیک خوش آمدید', style: theme.bodyLarge),
                  const SizedBox(height: 15),
                  Text.rich(
                    TextSpan(
                      text: ' ما یک پیامک حاوی کد تایید برای شماره  ',
                      style: theme.bodySmall!.copyWith(fontSize: 12),
                      children: <TextSpan>[
                        TextSpan(text: widget.mobileNumber, style: TextStyle(color: themeMode == ThemeMode.dark ? Colors.white : Colors.black, fontSize: 16)),
                        const TextSpan(text: '  ارسال کردیم'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 58),
                  Center(
                    child: PinInputTextField(
                      controller: pinEditingController,
                      decoration: pinDecoration,
                      pinLength: 5,
                      autoFocus: false,
                      textInputAction: TextInputAction.done,
                      onSubmit: (pin) {
                        mobileConfirmLogin();
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  remaining == '00:00'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('پیامک را دریافت نکردید ؟', style: TextStyle(fontSize: 14)),
                            TextButton(onPressed: () {}, child: const Text('دوباره ارسال کن', style: TextStyle(fontSize: 11))),
                          ],
                        )
                      : Center(child: Text('زمان باقی مانده : $remaining', style: theme.bodySmall!.copyWith(fontSize: 14))),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: mobileConfirmLogin,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width, 60),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: const Text('ورود', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
    );
  }
}
