import 'package:flutter/material.dart';

class CourseMeetingDetails extends StatelessWidget {
  final Map<String, dynamic> meeting;
  const CourseMeetingDetails({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: 10),
        Text('جزئیات جلسه', style: theme.titleMedium!.apply(color: Colors.blue)),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 12),
          child: Row(
            children: [
              Text('ماهیت جلسه : ', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
              Text(meeting['meeting_method'] ?? '', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 12),
          child: Row(
            children: [
              Text('نوع برگزاری : ', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
              Text(meeting['hold_course']['name'] ?? '', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 12, bottom: 10),
          child: Row(
            children: [
              Text('تلفن هماهنگی : ', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
              Text(meeting['support_phone'] ?? '', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('آدرس : ', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
              Flexible(
                child: Text(
                  meeting['address'] ?? '',
                  style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal),
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
                  Text('مدرس : ', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
                  Text(meeting['teacher'] ?? '', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
                ],
              ),
              Row(
                children: [
                  Text('ناظر : ', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
                  Text(meeting['supervisor'] ?? '', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(right: 12, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('توضیحات : ', style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
              Flexible(
                child: Text(
                  meeting['description'] ?? 'توضیحی وجود ندارد',
                  style: theme.titleSmall!.copyWith(fontWeight: FontWeight.normal),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
