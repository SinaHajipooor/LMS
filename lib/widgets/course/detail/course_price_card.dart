import 'package:flutter/material.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:provider/provider.dart';

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
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    return SizedBox(
      height: 70,
      width: deviceSize.width,
      child: Card(
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            width: deviceSize.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('قیمت دوره : ', style: Theme.of(context).textTheme.titleMedium),
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
                                  style: TextStyle(decoration: TextDecoration.lineThrough, color: themeMode == ThemeMode.dark ? Colors.white24 : Colors.black, decorationColor: Colors.red[800], fontSize: 20),
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
