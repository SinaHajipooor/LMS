import 'package:flutter/material.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:provider/provider.dart';

class LandingAppBar extends StatelessWidget {
  const LandingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 75,
      collapsedHeight: 75,
      title: Center(
        child: Container(
          margin: const EdgeInsets.only(right: 3, top: 20, bottom: 0),
          width: deviceSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/avatar-edu.png',
                width: 40,
                height: 40,
                color: themeMode == ThemeMode.dark ? Colors.white : Colors.black,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('سیستم', style: theme.textTheme.bodySmall!.copyWith(fontSize: 12)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 16),
                    child: Text(
                      "یادگیری الکترونیک",
                      style: theme.textTheme.titleMedium!.copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
