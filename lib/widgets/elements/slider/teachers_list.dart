import 'package:flutter/material.dart';
import 'package:lms/data/data.dart';
import 'package:lms/widgets/elements/slider/teacher_item.dart';

class TeachersList extends StatelessWidget {
  const TeachersList({super.key});
  @override
  Widget build(BuildContext context) {
    final teachers = AppDatabase.stories;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: teachers.isNotEmpty,
          child: SizedBox(
            height: 200, // Adjust the height to fit two rows
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of items per row
                mainAxisSpacing: 5, // Vertical spacing between items
                crossAxisSpacing: 10, // Horizontal spacing between items
              ),
              itemCount: teachers.length > 8 ? 8 : teachers.length,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              itemBuilder: (context, index) {
                final teacher = teachers[index];
                return TeacherItem(teacher: teacher);
              },
            ),
          ),
        ),
        Visibility(
          visible: teachers.isEmpty,
          child: SizedBox(
            height: 110,
            child: Center(
              child: Text(
                'مدرس وجود ندارد !',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ),
        )
      ],
    );
  }
}







// import 'package:flutter/material.dart';

// class TeachersList extends StatelessWidget {
//   const TeachersList({super.key});

//   // ------------- fields ----------------

//   // ------------- UI ----------------

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildTeacherWidget(),
//               _buildTeacherWidget(),
//               _buildTeacherWidget(),
//               _buildTeacherWidget(),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildTeacherWidget(),
//               _buildTeacherWidget(),
//               _buildTeacherWidget(),
//               _buildTeacherWidget(),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildTeacherWidget() {
//     return Column(
//       children: [
//         Container(
//           width: 55,
//           height: 55,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             image: const DecorationImage(
//               fit: BoxFit.cover,
//               image: AssetImage('assets/images/placeholder.png'),
//             ),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: FadeInImage.assetNetwork(
//               placeholder: 'assets/images/placeholder.png',
//               image: 'http://45.149.77.156:8080/portal-assets/img/team/team-1.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         const SizedBox(height: 4),
//         const Text(
//           'سیناحاجی‌پور',
//           style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }
// }
