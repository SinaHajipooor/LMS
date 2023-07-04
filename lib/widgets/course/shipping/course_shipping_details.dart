import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/spinner.dart';

class CourseShippingDetails extends StatelessWidget {
  // ------------------ feilds ----------------------
  final Map<String, dynamic> courseInfo;
  const CourseShippingDetails({super.key, required this.courseInfo});
  // ------------------ UI ----------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: Row(
              children: [
                Container(
                  width: 110,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      courseInfo['main_image'],
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) => Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                      ),
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: Spinner(
                            size: 25,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(courseInfo['title']),
                      Row(
                        children: [
                          const Text('تعداد فراگیران :  ', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          Text('${courseInfo['students_count']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [const Text('مدت دوره : ', style: TextStyle(fontSize: 12)), Text(courseInfo['time'], style: const TextStyle(fontSize: 13, color: Colors.red))],
                ),
                Row(
                  children: [
                    const Text('تعداد فصل‌ها : ', style: TextStyle(fontSize: 12)),
                    Text('${courseInfo['seasons_count']}', style: const TextStyle(fontSize: 13, color: Colors.orange)),
                  ],
                ),
                Row(
                  children: [
                    const Text('تعداد جلسات : ', style: TextStyle(fontSize: 12)),
                    Text('${courseInfo['sessions_count']}', style: const TextStyle(fontSize: 13, color: Colors.blue)),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [const Text('قیمت دوره : ', style: TextStyle(fontSize: 15)), Text(courseInfo['amount'], style: const TextStyle(fontSize: 14))],
                    ),
                    Row(
                      children: [
                        const Text('درصد تخفیف : ', style: TextStyle(fontSize: 15)),
                        Text(courseInfo['discount'], style: const TextStyle(fontSize: 14, color: Colors.green)),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [const Text('قیمت نهایی : '), Text(courseInfo['final_amount'], style: const TextStyle(fontSize: 18, color: Colors.blue)), const Text(' تومان', style: TextStyle(fontSize: 16, color: Colors.blue))],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
