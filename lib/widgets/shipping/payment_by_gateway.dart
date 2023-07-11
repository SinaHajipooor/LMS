import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/shipping/payment_gateways_list.dart';

class PaymentByGateway extends StatefulWidget {
  final List paymentGateways;

  const PaymentByGateway({super.key, required this.paymentGateways});
  @override
  State<PaymentByGateway> createState() => _PaymentByGatewayState();
}

class _PaymentByGatewayState extends State<PaymentByGateway> {
  int selectedPaymentGateway = 0;

  void showInputDialog() {
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('درگاه پرداخت مورد نظر خود را انتخاب کنید', style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14)),
            ),
            SizedBox(
              height: 185,
              child: PaymentGatewaysList(
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
        backgroundColor: Colors.blue,
        child: Image(
          width: 24,
          height: 24,
          image: AssetImage('assets/images/icons/person.png'),
        ),
      ),
      onTap: () => showInputDialog(),
      title: Text(
        'پرداخت توسط فراگیر',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        'درگاه پرداخت',
        style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.grey),
      ),
    );
  }
}
