import 'package:flutter/material.dart';
import 'package:lms/widgets/shipping/payment_by_gateway.dart';

class CoursePaymentApproachs extends StatefulWidget {
  final List paymentGateways;

  const CoursePaymentApproachs({super.key, required this.paymentGateways});
  @override
  State<CoursePaymentApproachs> createState() => _CoursePaymentApproachsState();
}

class _CoursePaymentApproachsState extends State<CoursePaymentApproachs> {
// -------------------- state ------------------------

// -------------------- methods ------------------------

// -------------------- UI ------------------------

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
          PaymentByGateway(paymentGateways: widget.paymentGateways),
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
