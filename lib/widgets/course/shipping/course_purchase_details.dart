import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/spinner.dart';

class CoursePurchaseDetails extends StatelessWidget {
  final String courseName;
  final String courseImageUrl;
  final int sessionsCount;
  final String coursePeriod;
  final String courseDiscount;
  final String courseTotalAmount;
  const CoursePurchaseDetails({
    super.key,
    required this.courseDiscount,
    required this.courseImageUrl,
    required this.sessionsCount,
    required this.coursePeriod,
    required this.courseName,
    required this.courseTotalAmount,
  });
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: deviceSize.height * 0.25,
        width: deviceSize.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 15, right: 8),
                      width: 150,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          courseImageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) => Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.cover,
                          ),
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: Spinner(
                                size: 15,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 7, top: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            courseName,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text('تعداد جلسات : ', style: TextStyle(fontSize: 12)),
                              Text('$sessionsCount', style: const TextStyle(fontSize: 13, color: Colors.blue)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text('مدت دوره : ', style: TextStyle(fontSize: 12)),
                              Text(coursePeriod, style: const TextStyle(fontSize: 13, color: Colors.red)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Text('درصد تخفیف : ', style: TextStyle(fontSize: 15)),
                          Text(courseDiscount, style: const TextStyle(fontSize: 15, color: Colors.green)),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('قیمت نهایی : '),
                          Text(courseTotalAmount, style: const TextStyle(fontSize: 15, color: Colors.blue)),
                          const Text(' تومان', style: TextStyle(fontSize: 17, color: Colors.blue)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
