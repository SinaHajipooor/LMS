import 'package:flutter/material.dart';
import 'package:lms/helpers/theme/theme_helper.dart';
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
      automaticallyImplyLeading: false,
      floating: false,
      expandedHeight: 75,
      collapsedHeight: 75,
      title: Center(
        child: Container(
          margin: const EdgeInsets.only(right: 0, top: 20, bottom: 0),
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
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('سامانه جامع', style: theme.textTheme.bodySmall!.copyWith(fontSize: 11)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 16),
                          child: Text(
                            "آموزش مدیران و کارکنان دولت",
                            style: theme.textTheme.titleMedium!.copyWith(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500), // Set the duration of the animation
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          final offsetAnimation = Tween<Offset>(
                            begin: const Offset(1, 0), // Set the initial offset for the animation
                            end: Offset.zero, // Set the final offset for the animation
                          ).animate(animation);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        child: InkWell(
                          key: ValueKey(themeMode), // Update when the theme changes
                          onTap: () {
                            Provider.of<MyThemeModel>(context, listen: false).toggleTheme();
                          },
                          child: Image.asset(
                            themeMode == ThemeMode.light ? 'assets/images/icons/night.png' : 'assets/images/icons/sun.png',
                            color: themeMode == ThemeMode.dark ? Colors.white : Colors.black,
                            width: themeMode == ThemeMode.dark ? 20 : 30,
                            height: themeMode == ThemeMode.dark ? 20 : 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
