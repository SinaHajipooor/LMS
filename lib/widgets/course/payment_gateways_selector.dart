import 'package:flutter/material.dart';
import '../../models/course/payment_gateways.dart';

class PaymentGatewaysSelector extends StatelessWidget {
//----------------- feilds -----------------
  final Function(int) onSelectPaymentGateway;
  final int selectedPaymentGateway;
  final List paymentGateways;

  const PaymentGatewaysSelector({super.key, required this.onSelectPaymentGateway, required this.selectedPaymentGateway, required this.paymentGateways});

  Widget _buildPaymentApproachCard({
    required int value,
    required String title,
    required String subtitle,
    required String logo,
  }) {
    return InkWell(
      onTap: () => onSelectPaymentGateway(value),
      child: Container(
        height: 80,
        // width: 230,
        child: Card(
          elevation: selectedPaymentGateway == value ? 3 : 1,
          shadowColor: selectedPaymentGateway == value ? Colors.blue : Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(logo),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: selectedPaymentGateway == value ? Colors.blue : Colors.black, fontWeight: selectedPaymentGateway == value ? FontWeight.bold : FontWeight.normal, fontSize: 14),
                    ),
                    Text(subtitle, style: const TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              Radio(
                value: value,
                groupValue: selectedPaymentGateway,
                onChanged: (value) {
                  onSelectPaymentGateway(value!);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: paymentGateways.map((paymentApproach) {
            return _buildPaymentApproachCard(
              value: paymentApproach['id'],
              title: paymentApproach['type'],
              subtitle: paymentApproach['name'],
              logo: paymentApproach['logo'],
            );
          }).toList(),
        ),
      ),
    );
  }
}
