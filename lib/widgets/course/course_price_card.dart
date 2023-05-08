import 'package:flutter/material.dart';

class CoursePriceCard extends StatelessWidget {
  // ----------------- feilds ----------------
  final String amount;
  final String discount;
  final String finalAmount;

  const CoursePriceCard({
    super.key,
    required this.amount,
    required this.discount,
    required this.finalAmount,
  });

  // ----------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: 70,
      width: deviceSize.width,
      child: Card(
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            width: deviceSize.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text('قیمت دوره : ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
                    ),
                    discount == '0'
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(amount, style: const TextStyle(fontSize: 20, color: Colors.blue)),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  amount,
                                  style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black45, decorationColor: Colors.red[800], fontSize: 20),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$finalAmount تومان',
                                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
