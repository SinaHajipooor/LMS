import 'package:flutter/material.dart';

class CoursePaymentApproachs extends StatelessWidget {
  const CoursePaymentApproachs({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 50),
      height: deviceSize.height * 0.65,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green[400],
              child: const Image(
                width: 24,
                height: 24,
                color: Colors.white,
                image: AssetImage('assets/images/icons/free.png'),
              ),
            ),
            onTap: () {},
            title: const Text(
              'رایگان',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const CircleAvatar(
              child: Image(
                width: 24,
                height: 24,
                image: AssetImage('assets/images/icons/person.png'),
              ),
            ),
            onTap: () {},
            title: const Text(
              'پرداخت توسط فراگیر',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'درگاه پرداخت',
              style: TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const CircleAvatar(
              child: Image(
                width: 22,
                height: 22,
                image: AssetImage('assets/images/icons/document.png'),
              ),
            ),
            onTap: () {},
            title: const Text(
              'پرداخت توسط فراگیر',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'سند بانکی',
              style: TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Image(
                width: 25,
                height: 25,
                image: AssetImage('assets/images/icons/office.png'),
              ),
            ),
            onTap: () {},
            title: const Text(
              'پرداخت توسط دستگاه اجرایی',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
