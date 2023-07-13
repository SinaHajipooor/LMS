// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:lms/providers/Profile/PassedCourses/ExternalPassedCoursesProvider.dart';
// import 'package:lms/widgets/elements/spinner.dart';
// import 'package:lms/widgets/profile/passedCourses/external/external_passed_courses_form.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ExternalPassedCoursesModal extends StatefulWidget {
//   final double deviceHeight;

//   const ExternalPassedCoursesModal({
//     required this.deviceHeight,
//     Key? key,
//   }) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _ExternalPassedCoursesModalState createState() => _ExternalPassedCoursesModalState();
// }

// class _ExternalPassedCoursesModalState extends State<ExternalPassedCoursesModal> {
//   final ScrollController _scrollController = ScrollController();
//   bool _isLoading = false;
//   File? filePath;
//   Map<String, dynamic> externalCourseInfo = {
//     'user_id': '',
//     'title': '',
//     'address': '',
//     'start_date': '',
//     'end_date': '',
//     'duration': '',
//     'institute_title': '',
//     'has_certificate': false,
//     'status': false,
//     'is_related': false,
//   };

//   Future<void> _selectFile() async {
//     try {
//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
//       );
//       if (result != null && result.files.isNotEmpty) {
//         final file = File(result.files.single.path!);
//         if (file.existsSync()) {
//           setState(() {
//             filePath = file;
//           });
//         } else {
//           throw Exception('File does not exist');
//         }
//       }
//     } catch (error) {
//       print(error);
//       // Handle the error
//     }
//   }

//   Future<void> addExternalCourse() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userId = prefs.getString('userId');
//     setState(() {
//       externalCourseInfo['user_id'] = userId;
//       _isLoading = true;
//     });
//     await Provider.of<ExternalPassedCoursesProvider>(context, listen: false).addExternalCourse(externalCourseInfo, filePath!);
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final keyboardOffset = MediaQuery.of(context).viewInsets.bottom;
//     final theme = Theme.of(context);
//     return StatefulBuilder(
//       builder: (context, setState) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (keyboardOffset > 0) {
//             setState(() {
//               _scrollController.animateTo(
//                 _scrollController.position.minScrollExtent,
//                 duration: const Duration(milliseconds: 200),
//                 curve: Curves.easeOut,
//               );
//             });
//           }
//         });
//         return SingleChildScrollView(
//           controller: _scrollController,
//           padding: EdgeInsets.only(
//             bottom: keyboardOffset + MediaQuery.of(context).padding.bottom,
//           ),
//           child: SizedBox(
//             height: widget.deviceHeight * 0.6,
//             child: Column(
//               children: [
//                 Container(
//                   height: 50, // adjust as needed
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   alignment: Alignment.center,
//                   child: Text(
//                     'ایجاد دوره گذرانده شده خارج مرکز',
//                     style: theme.textTheme.titleMedium!.apply(color: Colors.blue),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(Colors.red[400]!),
//                           ),
//                           child: const Text('انصراف'),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                         child: ElevatedButton(
//                           onPressed: () => addExternalCourse(),
//                           child: const Text('ذخیره'),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
