import 'package:flutter/material.dart';
import '../screens/dashbord_screen.dart';
import '../screens/course/electronic_courses_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppBottomTabs extends StatefulWidget {
  const AppBottomTabs({super.key});

  @override
  State<AppBottomTabs> createState() => _AppBottomTabsState();
}

class _AppBottomTabsState extends State<AppBottomTabs> {
// --------------- state -----------------
  int _currentIndex = 1;
  final List<Widget> _children = [
    const ElectronicCoursesScreen(),
    DashbordScreen(),
    const ProfileScreen(),
  ];

// --------------- methods -----------------
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 13,
        unselectedFontSize: 11,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection_outlined, size: 20),
            label: 'دوره‌های‌آموزشی',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 20),
            label: 'داشبورد',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 20),
            label: 'پروفایل',
          ),
        ],
      ),
    );
  }
}
