import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/Auth/AuthProvider.dart';
import '../widgets/elements/spinner.dart';
import './Home_screen.dart';

class AuthenticateScreen extends StatefulWidget {
// feilds
  static const routeName = '/authenticate-screen';

  const AuthenticateScreen({super.key});
  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  // --------------- state ----------------
  // OtpFieldController otpFieldController = OtpFieldController();
  final TextEditingController pinEditingController = TextEditingController();
  String mobileNumber = '';
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
  void didChangeDependencies() {
    final Map<String, dynamic> userData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      mobileNumber = userData['mobile'];
    });
    super.didChangeDependencies();
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
    final deviceSize = MediaQuery.of(context).size;
    final remainingDuration = Duration(seconds: _startSeconds);
    final remaining = '${remainingDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    final PinDecoration pinDecoration = BoxLooseDecoration(
      strokeColorBuilder: PinListenColorBuilder(Colors.grey.shade600.withOpacity(0.2), Colors.grey.shade300),
      radius: const Radius.circular(10),
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _isLoading
            ? const Center(child: Spinner(size: 40))
            : Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login-background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 13),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 85, width: 85, child: Image.asset('assets/images/favagostar-logo.png')),
                            const SizedBox(height: 16),
                            const Text('سیستم یادگیری الکترونیک', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 38),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text.rich(
                                TextSpan(text: ' ما یک پیامک حاوی کد تایید برای شماره ', style: TextStyle(fontSize: 12, color: Colors.grey.shade700), children: <TextSpan>[
                                  TextSpan(text: mobileNumber, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15)),
                                  const TextSpan(text: ' ارسال کردیم'),
                                ]),
                                textAlign: TextAlign.center,
                              )),
                            ),
                            const SizedBox(height: 10),
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
                            const SizedBox(height: 30),
                            remaining == '00:00'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('آیا پیامک را دریافت نکردید ؟', style: TextStyle(fontSize: 14)),
                                      TextButton(onPressed: () {}, child: const Text('دوباره ارسال کن', style: TextStyle(fontSize: 13))),
                                    ],
                                  )
                                : Center(child: Text('زمان باقی مانده : $remaining', style: TextStyle(fontSize: 14.0, color: Colors.grey.shade800))),
                            const SizedBox(height: 25),
                            Center(
                              child: SizedBox(
                                width: deviceSize.width - 50,
                                height: 45,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: ElevatedButton(onPressed: mobileConfirmLogin, child: const Text('ورود', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
