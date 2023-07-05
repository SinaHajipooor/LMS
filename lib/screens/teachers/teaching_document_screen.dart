import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/navigation/bottom_tabas.dart';
import 'package:lms/providers/Teachers/TeachersPanelProvider.dart';
import 'package:lms/widgets/elements/custom_appbar.dart';
import 'package:lms/widgets/elements/spinner.dart';
// import 'package:lms/widgets/teachersPanel/teacher_coureses_list.dart';
import 'package:provider/provider.dart';

class TeachingDocumentScreen extends StatefulWidget {
  const TeachingDocumentScreen({super.key});

  @override
  State<TeachingDocumentScreen> createState() => _TeachingDocumentScreenState();
}

class _TeachingDocumentScreenState extends State<TeachingDocumentScreen> {
  //----------------------- state -----------------------
  bool _isLoading = false;
  final _scrollController = ScrollController();
  // ignore: unused_field
  bool _isFabVisible = true;
  // ignore: unused_field
  List<dynamic> _allTeacherCourses = [];
  //----------------------- lifecycle -----------------------

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _isFabVisible = false;
        });
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _isFabVisible = true;
        });
      }
    });
  }

  //----------------------- methods -----------------------
  Future<void> _fetchAllTeacherCourses() async {
    await Provider.of<TeachersPanelProvider>(context, listen: false).fetchAllTeacherCourses();
    if (mounted) {
      setState(() {
        _allTeacherCourses = Provider.of<TeachersPanelProvider>(context, listen: false).allTeacherCourses;
        _isLoading = false;
      });
    }
  }

  //----------------------- UI -----------------------
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BottomTabs(defaultPageIndex: 2)));
        return false;
      },
      child: Scaffold(
        body: _isLoading
            ? const Center(child: Spinner(size: 35))
            : Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      const CustomAppbar(title: 'پرونده تدریس'),
                      SliverList(
                        delegate: SliverChildListDelegate.fixed([
                          // TeacherCoursesList(teacherCurrentCourses: _allTeacherCourses)
                        ]),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
