import 'package:flutter/material.dart';
import '../../screens/course/electronic_course_detail_screen.dart';

class CourseListItem extends StatelessWidget {
  const CourseListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4,
        child: Center(
          child: ListTile(
            leading: const CircleAvatar(backgroundImage: AssetImage('assets/images/avatar.png')),
            title: const Text('آموزش طراحی اپلیکیشن', style: TextStyle(fontSize: 14)),
            subtitle: const Text('قیمت : 850,200', style: TextStyle(fontSize: 11)),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart, color: Colors.green, size: 20)),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushNamed(ElectronicCourseDetailScreen.routeName);
            },
          ),
        ),
      ),
    );
    ;
  }
}
