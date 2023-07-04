import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/three_line_input.dart';

class CourseMeetingDetails extends StatelessWidget {
  final Map<String, dynamic> meeting;
  const CourseMeetingDetails({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text('جزئیات جلسه', style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 12),
          child: Row(
            children: [
              const Text('ماهیت جلسه : ', style: TextStyle(fontSize: 14)),
              Text(meeting['meeting_method'], style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 12),
          child: Row(
            children: [
              const Text('نوع برگزاری : ', style: TextStyle(fontSize: 14)),
              Text(meeting['hold_course']['name'], style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 12),
          child: Row(
            children: [
              const Text('زمان شروع : ', style: TextStyle(fontSize: 14)),
              Text(meeting['start_meet'], style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12, top: 15),
          child: Row(
            children: [
              const Text('زمان پایان : ', style: TextStyle(fontSize: 14)),
              Text(meeting['end_meet'], style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 12, bottom: 10),
          child: Row(
            children: [
              const Text('تلفن هماهنگی : ', style: TextStyle(fontSize: 14)),
              Text(meeting['support_phone'], style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('آدرس : ', style: TextStyle(fontSize: 14)),
              Flexible(
                child: Text(
                  meeting['address'],
                  style: const TextStyle(fontSize: 13),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 12, left: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('مدرس : ', style: TextStyle(fontSize: 14)),
                  Text(meeting['teacher'], style: const TextStyle(fontSize: 14)),
                ],
              ),
              Row(
                children: [
                  const Text('ناظر : ', style: TextStyle(fontSize: 14)),
                  Text(meeting['supervisor'], style: const TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        ThreeLineInput(value: meeting['description'], label: 'توضیحات', onChanged: (value) {}),
      ],
    );
  }
}
