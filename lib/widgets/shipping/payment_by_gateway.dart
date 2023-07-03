import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/course/payment_gateways_list.dart';

class PaymentByGateway extends StatefulWidget {
  final List paymentGateways;

  PaymentByGateway({required this.paymentGateways});
  @override
  State<PaymentByGateway> createState() => _PaymentByGatewayState();
}

class _PaymentByGatewayState extends State<PaymentByGateway> {
  int selectedPaymentGateway = 0;

  void showInputDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('درگاه پرداخت مورد نظر خود را انتخاب کنید', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 185,
              child: PaymentGatewaysList(
                onSelectPaymentGateway: setSelectedPaymentGateways,
                selectedPaymentGateway: selectedPaymentGateway,
                paymentGateways: widget.paymentGateways,
              ),
            ),
          ],
        ),
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

  void setSelectedPaymentGateways(int paymentGateways) {
    setState(() {
      selectedPaymentGateway = paymentGateways;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Image(
          width: 24,
          height: 24,
          image: AssetImage('assets/images/icons/person.png'),
        ),
      ),
      onTap: () => showInputDialog(),
      title: const Text(
        'پرداخت توسط فراگیر',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        'درگاه پرداخت',
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
