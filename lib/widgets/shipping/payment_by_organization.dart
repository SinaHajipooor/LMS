import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class PaymentByOrganization extends StatefulWidget {
  const PaymentByOrganization({super.key});

  @override
  State<PaymentByOrganization> createState() => _PaymentByOrganizationState();
}

class _PaymentByOrganizationState extends State<PaymentByOrganization> {
  void showSucessDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      body: const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'درخواست شما با موفقیت ثبت گردید',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      btnOk: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        child: const Text('تایید'),
      ),
    ).show();
  }

  void showInputDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      body: const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'رویکرد پرداخت توسط دستگاه اجرایی را انتخاب می‌کنید ؟',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      btnOk: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          showSucessDialog();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        child: const Text('تایید'),
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
      onTap: () => showInputDialog(),
      title: const Text(
        'پرداخت توسط دستگاه اجرایی',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
