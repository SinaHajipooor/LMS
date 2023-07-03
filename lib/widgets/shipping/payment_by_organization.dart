import 'package:flutter/material.dart';

class PaymentByOrganization extends StatefulWidget {
  const PaymentByOrganization({super.key});

  @override
  State<PaymentByOrganization> createState() => _PaymentByOrganizationState();
}

class _PaymentByOrganizationState extends State<PaymentByOrganization> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
