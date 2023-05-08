import 'package:flutter/material.dart';

class PaymentApproachSelector extends StatelessWidget {
//----------------- feilds -----------------
  final Function(int) onSelectPAymentApproach;
  final int selectedPaymentApproach;
  final String finalAmount;
  const PaymentApproachSelector({super.key, required this.onSelectPAymentApproach, required this.selectedPaymentApproach, required this.finalAmount});

  Widget _buildPaymentApproachCard({
    required int value,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () => onSelectPAymentApproach(value),
      child: Container(
        width: 140,
        child: Card(
          shadowColor: selectedPaymentApproach == value ? Colors.blue : Colors.black,
          elevation: selectedPaymentApproach == value ? 3 : 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: selectedPaymentApproach == value ? 12 : 11,
                    fontWeight: selectedPaymentApproach == value ? FontWeight.bold : FontWeight.normal,
                    color: selectedPaymentApproach == value ? Colors.blue : Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: selectedPaymentApproach == value ? 12 : 11,
                    fontWeight: selectedPaymentApproach == value ? FontWeight.bold : FontWeight.normal,
                    color: selectedPaymentApproach == value ? Colors.blue : Colors.black,
                  ),
                ),
                Radio(
                  value: value,
                  groupValue: selectedPaymentApproach,
                  onChanged: (value) {
                    onSelectPAymentApproach(value as int);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: finalAmount == '0',
              child: _buildPaymentApproachCard(
                value: 0,
                title: 'رایگان',
                subtitle: '',
              ),
            ),
            Visibility(
              visible: finalAmount != '0',
              child: _buildPaymentApproachCard(
                value: 1,
                title: 'پرداخت توسط فراگیر',
                subtitle: 'درگاه پرداخت',
              ),
            ),
            Visibility(
              visible: finalAmount != '0',
              child: _buildPaymentApproachCard(
                value: 2,
                title: 'پرداخت توسط فراگیر',
                subtitle: 'سند بانکی',
              ),
            ),
            Visibility(
              visible: finalAmount != '0',
              child: _buildPaymentApproachCard(
                value: 3,
                title: 'پرداخت توسط',
                subtitle: 'دستگاه اجرایی',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
