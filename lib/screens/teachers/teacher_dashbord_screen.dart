import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/helpers/connections/internet_connectivity_helper.dart';
import 'package:lms/navigation/StudentsPanel/bottomTab/students_bottom_tabas.dart';
import 'package:lms/navigation/TeachersPanel/drawer/teachers_panel_drawer.dart';
import 'package:lms/providers/Teachers/TeachersPanelProvider.dart';
import 'package:lms/screens/profile/user/user_profile_screen.dart';
import 'package:lms/widgets/dashbord/calender.dart';
import 'package:lms/widgets/dashbord/dashbord_info_cards.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:provider/provider.dart';

class TeacherDashbordScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TeacherDashbordScreen({super.key});

  @override
  State<TeacherDashbordScreen> createState() => _TeacherDashbordScreenState();
}

class _TeacherDashbordScreenState extends State<TeacherDashbordScreen> {
  //----------------- state --------------------
  final _scrollController = ScrollController();
  // ignore: unused_field
  bool _isFabVisible = true;
  bool _isLoading = false;
  // ignore: unused_field
  List<dynamic> _teacherCurrentCourses = [];
  //----------------- lifecycle --------------------

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
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

  //----------------- methods --------------------
  Future<void> _fetchTeacherCurrentCourses() async {
    await Provider.of<TeachersPanelProvider>(context, listen: false).fetchAllTeacherCurrentCourses();
    if (mounted) {
      setState(() {
        _teacherCurrentCourses = Provider.of<TeachersPanelProvider>(context, listen: false).teacherCurrentCourses;
        _isLoading = false;
      });
    }
  }

  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  //----------------- UI --------------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const StudentsBottomTabs(defaultPageIndex: 1)));
        return false;
      },
      child: Scaffold(
        key: widget._scaffoldKey,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: theme.appBarTheme.backgroundColor,
          leading: Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: theme.appBarTheme.iconTheme!.color),
                onPressed: () => widget._scaffoldKey.currentState?.openDrawer(),
              ),
            ],
          ),
          actions: [
            InkWell(
              child: Container(
                margin: const EdgeInsets.only(left: 12, top: 10),
                child: Stack(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                      radius: 18,
                    ),
                    Positioned(
                      right: -1,
                      top: 20,
                      bottom: 1,
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 109, 223, 113)),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName);
              },
            ),
          ],
        ),
        drawer: const TeachersPanelDrawer(),
        body: _isLoading
            ? const Center(child: Spinner(size: 35))
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PersianFullCalendar(
                      calendarUsecase: 2,
                    ),
                    const SizedBox(height: 10),
                    const DashbordInfoCards(),
                    Padding(
                      padding: const EdgeInsets.only(top: 35, right: 15),
                      child: Text('دوره های جاری', style: theme.textTheme.titleMedium),
                    ),
                    // TeacherCoursesList(teacherCurrentCourses: _teacherCurrentCourses)
                  ],
                ),
              ),
      ),
    );
  }
}
