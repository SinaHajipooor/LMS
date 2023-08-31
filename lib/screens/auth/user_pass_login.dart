import 'package:flutter/material.dart';
import 'package:lms/providers/Auth/AuthProvider.dart';
import 'package:lms/screens/root/home_screen.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:provider/provider.dart';

class UserPassLogin extends StatefulWidget {
  const UserPassLogin({super.key});

  @override
  State<UserPassLogin> createState() => _UserPassLoginState();
}

class _UserPassLoginState extends State<UserPassLogin> {
  // ------------------------ state ------------------------
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  bool _isLoading = false;
  bool _isObscure = true;

  // ------------------------ methods ------------------------

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

  // ------------------------ UI ------------------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return _isLoading
        ? const Center(child: Spinner(size: 20))
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 38, 32, 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'سامانه جامع آموزش مدیران و کارکنان دولت',
                      style: theme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'اطلاعات کاربری خود را وارد کنید',
                      style: theme.bodySmall!.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      style: theme.bodyMedium!.copyWith(fontSize: 17),
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
                        label: Text(
                          'نام کاربری',
                          style: theme.bodySmall,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'از صحت نام‌کاربری خود مطمئن شوید';
                        }
                        setState(() {
                          _password = value;
                        });
                        return null;
                      },
                      onSaved: (String? value) {
                        _password = value!;
                      },
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: _isObscure,
                      style: theme.bodyMedium!.copyWith(fontSize: 17),
                      decoration: InputDecoration(
                        label: Text(
                          'رمز عبور',
                          style: theme.bodySmall,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(
                            _isObscure ? Icons.visibility_off : Icons.visibility,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          userPassLoginHandler();
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
                      child: const Text('ورود', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'رمز عبور خود را فراموش کردید ؟',
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'بازیابی رمز عبور',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
