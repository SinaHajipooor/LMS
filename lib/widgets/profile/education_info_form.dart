import 'package:flutter/material.dart';

class EducationInfoForm extends StatelessWidget {
  static const routeName = '/education-info-form-screen';

  const EducationInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        automaticallyImplyLeading: false,
        title: const Text('ایجاد اطلاعات تحصیلی', style: TextStyle(color: Colors.black, fontSize: 13)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined, color: Colors.black)),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
