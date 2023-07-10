import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      title: Text(title, style: theme.textTheme.titleSmall),
      backgroundColor: Colors.white,
      titleSpacing: 32,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded, color: Colors.black)),
        const SizedBox(width: 16),
      ],
    );
  }
}
