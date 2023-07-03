import 'package:flutter/material.dart';
import 'package:lms/widgets/shipping/free_register.dart';
import 'package:lms/widgets/shipping/payment_by_bank_document.dart';
import 'package:lms/widgets/shipping/payment_by_gateway.dart';
import 'package:lms/widgets/shipping/payment_by_organization.dart';

class CoursePaymentApproachs extends StatefulWidget {
  final List paymentGateways;

  const CoursePaymentApproachs({super.key, required this.paymentGateways});
  @override
  State<CoursePaymentApproachs> createState() => _CoursePaymentApproachsState();
}

class _CoursePaymentApproachsState extends State<CoursePaymentApproachs> {
// -------------------- state ------------------------

// -------------------- methods ------------------------

// -------------------- UI ------------------------

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 50),
      height: deviceSize.height * 0.65,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const FreeRegister(),
          const SizedBox(height: 15),
          PaymentByGateway(paymentGateways: widget.paymentGateways),
          const SizedBox(height: 15),
          const PaymentByBankDocument(),
          const SizedBox(height: 15),
          const PaymentByOrganization(),
        ],
      ),
    );
  }
}
