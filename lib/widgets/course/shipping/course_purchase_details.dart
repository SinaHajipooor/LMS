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
    final theme = Theme.of(context);
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
            elevation: 1,
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
                      padding: const EdgeInsets.only(right: 15, top: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            courseName,
                            style: theme.textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text('تعداد جلسات : ', style: theme.textTheme.bodyMedium),
                              Text('$sessionsCount', style: const TextStyle(fontSize: 13, color: Colors.blue)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text('مدت دوره : ', style: theme.textTheme.bodyMedium),
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
                          Text(
                            'درصد تخفیف : ',
                            style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
                          ),
                          Text(courseDiscount, style: const TextStyle(fontSize: 15, color: Colors.green)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('قیمت نهایی : ', style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal)),
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
