import 'package:flutter/material.dart';

class PaymentGatewaysList extends StatelessWidget {
  final Function(int) onSelectPaymentGateway;
  final int selectedPaymentGateway;
  final List paymentGateways;
  const PaymentGatewaysList({
    Key? key,
    required this.onSelectPaymentGateway,
    required this.selectedPaymentGateway,
    required this.paymentGateways,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: paymentGateways.length,
      itemBuilder: (context, index) {
        final paymentGateway = paymentGateways[index];
        return InkWell(
          onTap: () => onSelectPaymentGateway(paymentGateway['id']),
          child: ListTile(
            title: Text(
              paymentGateway['type'],
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              paymentGateway['name'],
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(paymentGateway['logo']),
            ),
            trailing: Radio(
              value: paymentGateway['id'],
              groupValue: selectedPaymentGateway,
              onChanged: (value) {
                onSelectPaymentGateway(value);
              },
            ),
          ),
        );
      },
    );
  }
}
