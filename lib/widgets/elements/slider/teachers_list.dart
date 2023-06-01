import 'package:flutter/material.dart';

class TeachersList extends StatelessWidget {
  const TeachersList({super.key});

  // ------------- fields ----------------

  // ------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTeacherWidget(),
              _buildTeacherWidget(),
              _buildTeacherWidget(),
              _buildTeacherWidget(),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTeacherWidget(),
              _buildTeacherWidget(),
              _buildTeacherWidget(),
              _buildTeacherWidget(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTeacherWidget() {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/placeholder.png'),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image: 'http://45.149.77.156:8080/portal-assets/img/team/team-1.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'سیناحاجی‌پور',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
