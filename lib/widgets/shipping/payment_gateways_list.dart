import 'package:flutter/material.dart';

class PaymentGatewaysList extends StatefulWidget {
  final List paymentGateways;
  const PaymentGatewaysList({
    Key? key,
    required this.paymentGateways,
  }) : super(key: key);

  @override
  State<PaymentGatewaysList> createState() => _PaymentGatewaysListState();
}

class _PaymentGatewaysListState extends State<PaymentGatewaysList> {
  int selectedPaymentGateway = 1;
  void setSelectedPaymentGateways(int paymentGateways) {
    setState(() {
      selectedPaymentGateway = paymentGateways;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.paymentGateways.length,
      itemBuilder: (context, index) {
        final paymentGateway = widget.paymentGateways[index];
        return InkWell(
          onTap: () => setSelectedPaymentGateways(paymentGateway['id']),
          child: ListTile(
            title: Text(
              paymentGateway['type'],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
            ),
            subtitle: Text(paymentGateway['name'], style: Theme.of(context).textTheme.bodySmall),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(paymentGateway['logo']),
            ),
            trailing: Radio(
              value: paymentGateway['id'],
              groupValue: selectedPaymentGateway,
              onChanged: (value) {
                setSelectedPaymentGateways(value);
              },
            ),
          ),
        );
      },
    );
  }
}
