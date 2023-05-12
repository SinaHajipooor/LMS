import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/elements/spinner.dart';
import '../providers/Course/CourseProvider.dart';
import '../widgets/course/payment_approach_selector.dart';
import '../widgets/course/bank_payment_approach.dart';
import '../widgets/course/payment_gateways_selector.dart';
import '../widgets/course/course_shipping_details.dart';

class ShoppingBasketScreen extends StatefulWidget {
// ------------------ feilds ---------------------
  static const routeName = '/shopping-basket-screen';

  const ShoppingBasketScreen({super.key});

  @override
  State<ShoppingBasketScreen> createState() => _ShoppingBasketScreenState();
}

class _ShoppingBasketScreenState extends State<ShoppingBasketScreen> {
// ------------------ state ---------------------
  int selectedPaymentApproach = 1;
  Map<String, dynamic>? courseInfo;
  bool _isLoading = false;
  int selectedPaymentGateway = 1;
// ------------------ lifecycle -----------------

  @override
  void didChangeDependencies() {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    fetchCourseShippingDetails(id);
    super.didChangeDependencies();
  }

// ------------------ methods -----------------
  Future<void> fetchCourseShippingDetails(int courseId) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    await Provider.of<CourseProvider>(context, listen: false).fetchCourseShippingDetails(courseId);
    if (mounted) {
      setState(() {
        courseInfo = Provider.of<CourseProvider>(context, listen: false).courseShippingDetails;
        _isLoading = false;
      });
    }
  }

  void setSelectedPaymentApproach(int paymentApproach) {
    if (mounted) {
      setState(() {
        selectedPaymentApproach = paymentApproach;
      });
    }
  }

  void setSelectedPaymentGateways(int paymentGateways) {
    if (mounted) {
      setState(() {
        selectedPaymentGateway = paymentGateways;
      });
    }
  }

// ------------------ UI ---------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('خرید دوره', style: TextStyle(color: Colors.black, fontSize: 16)),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: Spinner(size: 40))
          : SingleChildScrollView(
              child: Column(
                children: [
                  CourseShippingDetails(courseInfo: courseInfo!),
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 15),
                          child: Text(
                            'رویکرد پرداخت',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        // const Divider(),
                        const SizedBox(height: 10),
                        PaymentApproachSelector(
                          onSelectPAymentApproach: setSelectedPaymentApproach,
                          selectedPaymentApproach: selectedPaymentApproach,
                          finalAmount: courseInfo?['final_amount'],
                        ),
                        AnimatedOpacity(
                          opacity: selectedPaymentApproach == 0 ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                          child: Visibility(
                            visible: selectedPaymentApproach == 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: FloatingActionButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    child: const Text('تایید'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: selectedPaymentApproach == 1 ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                          child: Visibility(
                            visible: selectedPaymentApproach == 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                              child: Column(
                                children: [
                                  PaymentGatewaysSelector(
                                    onSelectPaymentGateway: setSelectedPaymentGateways,
                                    selectedPaymentGateway: selectedPaymentGateway,
                                    paymentGateways: Provider.of<CourseProvider>(context).coursePaymentGateways,
                                  ),
                                  const SizedBox(height: 25),
                                  Container(
                                    height: 45,
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 2),
                                          child: ElevatedButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red[400]!),
                                            ),
                                            child: const Text('انصراف'),
                                          ),
                                        )),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 2),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                            ),
                                            child: const Text('پرداخت'),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: selectedPaymentApproach == 2 ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                          child: Visibility(
                            visible: selectedPaymentApproach == 2,
                            child: const BankPaymentApproach(),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
