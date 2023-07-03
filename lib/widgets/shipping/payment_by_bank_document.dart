import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/shipping/payment_by_bank_documnt_form.dart';

class PaymentByBankDocument extends StatefulWidget {
  const PaymentByBankDocument({super.key});

  @override
  State<PaymentByBankDocument> createState() => _PaymentByBankDocumentState();
}

class _PaymentByBankDocumentState extends State<PaymentByBankDocument> {
  void showInputDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: PaymentByBankDocumentForm(),
      ),
      btnOk: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        child: const Text('پرداخت'),
      ),
      btnCancel: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        child: const Text('لغو'),
      ),
    ).show();
  }

  // ------------------- UI --------------------
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
      onTap: () => showInputDialog(),
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
