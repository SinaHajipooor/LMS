import 'package:flutter/material.dart';
import '../screens/dashbord_screen.dart';
import '../screens/course/electronic_courses_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/course/simple_courses_screen.dart';

class AppBottomTabs extends StatefulWidget {
  const AppBottomTabs({super.key});

  @override
  State<AppBottomTabs> createState() => _AppBottomTabsState();
}

class _AppBottomTabsState extends State<AppBottomTabs> {
// --------------- state -----------------
  int _currentIndex = 2;
  final List<Widget> _children = [
    const ElectronicCoursesScreen(),
    const SimpleCoursesScreen(),
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
        selectedFontSize: 11,
        unselectedFontSize: 9,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.computer, size: 20),
            label: 'دوره های الکترونیک',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt, size: 20),
            label: 'دوره های حضوری',
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
