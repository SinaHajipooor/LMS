import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      title: Text(title, style: const TextStyle(fontSize: 13, color: Colors.black)),
      backgroundColor: Colors.white,
      titleSpacing: 32,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded, color: Colors.black)),
        const SizedBox(width: 16),
      ],
    );
  }
}
