import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './authenticate_screen.dart';
import '../widgets/elements/spinner.dart';
import '../providers/Auth/AuthProvider.dart';
import './home_screen.dart';

class LoginScreen extends StatefulWidget {
  // fields
  static const routeName = 'login-screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // --------------- state ----------------
  final _formKey = GlobalKey<FormState>();
  bool isMobileLogin = false;
  bool _isLoading = false;
  String? _mobile;
  String? _username;
  String? _password;
  bool isRemember = false;
  bool showEnteredPass = true;
  // ------------- methods -------------
  Future<void> mobileLoginHandler() async {
    setState(() {
      _isLoading = true;
    });
    final userMobile = _mobile.toString();
    await Provider.of<AuthProvider>(context, listen: false).mobileLogin(userMobile);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(AuthenticateScreen.routeName, arguments: {'mobile': _mobile});
  }

  Future<void> userPassLoginHandler() async {
    setState(() {
      _isLoading = true;
    });
    final userData = {'username': _username, 'password': _password};
    await Provider.of<AuthProvider>(context, listen: false).userPassLogin(userData);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
  // --------------- UI ----------------

  @override
  Widget build(BuildContext context) {
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Center(
                    child: isMobileLogin
                        ? Card(
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
                                  Form(
                                    key: _formKey,
                                    child: TextFormField(
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
                                      decoration: InputDecoration(
                                        labelText: 'شماره‌موبایل',
                                        labelStyle: const TextStyle(fontSize: 12),
                                        errorStyle: const TextStyle(fontSize: 11),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              value: isRemember,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  isRemember = newValue!;
                                                });
                                              },
                                            ),
                                            const Text('مرا‌بخاطر‌بسپار', style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isMobileLogin = false;
                                          });
                                        },
                                        child: const Text('ورود با نام‌کاربری', style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.95,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          mobileLoginHandler();
                                        }
                                      },
                                      child: const Text('ورود'),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          )
                        : Card(
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
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'از صحت نام‌کاربری خود مطمئن شوید';
                                            }
                                            setState(() {
                                              _username = value;
                                            });

                                            return null;
                                          },
                                          onSaved: (String? value) {
                                            _username = value!;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'نام‌کاربری',
                                            labelStyle: const TextStyle(fontSize: 12),
                                            errorStyle: const TextStyle(fontSize: 11),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                              borderRadius: BorderRadius.circular(7.0),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          obscureText: showEnteredPass,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'از صحت رمز عبور خود مطمئن شوید';
                                            }
                                            setState(() {
                                              _password = value;
                                            });
                                            return null;
                                          },
                                          onSaved: (String? value) {
                                            _password = value;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'رمز‌عبور',
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                                            labelStyle: const TextStyle(fontSize: 12),
                                            errorStyle: const TextStyle(fontSize: 11),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(7.0),
                                            ),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  showEnteredPass = !showEnteredPass;
                                                });
                                              },
                                              icon: Icon(
                                                showEnteredPass ? Icons.visibility_off : Icons.visibility,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              value: isRemember,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  isRemember = newValue!;
                                                });
                                              },
                                            ),
                                            const Text('مرا‌بخاطر‌بسپار', style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isMobileLogin = true;
                                            });
                                          },
                                          child: const Text('ورود با‌شماره‌موبایل', style: TextStyle(fontSize: 12))),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.95,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          userPassLoginHandler();
                                        }
                                      },
                                      child: const Text('ورود'),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
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
