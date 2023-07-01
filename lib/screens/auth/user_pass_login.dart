import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/password_textFeild.dart';

class UserPassLogin extends StatelessWidget {
  const UserPassLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 38, 32, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'به سیستم یادگیری الکترونیک خوش آمدید',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'اطلاعات کاربری خود را وارد کنید',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 26),
            const TextField(
              decoration: InputDecoration(
                label: Text(
                  'نام کاربری',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const PasswordTextFeild(),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
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
    );
  }
}
