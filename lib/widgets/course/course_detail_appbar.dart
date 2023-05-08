import 'package:flutter/material.dart';

class CourseDetailAppbar extends StatelessWidget {
  const CourseDetailAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      title: const Text('اطلاعات دوره', style: TextStyle(fontSize: 13, color: Colors.black)),
      backgroundColor: Colors.white,
      titleSpacing: 32,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded, color: Colors.black)),
        const SizedBox(width: 16),
      ],
    );
  }
}
