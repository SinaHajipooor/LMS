import 'package:flutter/material.dart';

class PaymentByBankDocument extends StatefulWidget {
  const PaymentByBankDocument({super.key});

  @override
  State<PaymentByBankDocument> createState() => _PaymentByBankDocumentState();
}

class _PaymentByBankDocumentState extends State<PaymentByBankDocument> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
