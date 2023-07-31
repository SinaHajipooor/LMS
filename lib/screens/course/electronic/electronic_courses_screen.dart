import 'package:flutter/material.dart';
import 'package:lms/helpers/internet_connectivity_helper.dart';
import 'package:lms/screens/root/landing_screen.dart';
import 'package:provider/provider.dart';
import '../../../widgets/course/electronic/electronic_courses_list.dart';
import '../../../providers/Course/ElectronicCourseProvider.dart';
import '../../../widgets/elements/spinner.dart';

enum FilterOptions { List, Item }

class ElectronicCoursesScreen extends StatefulWidget {
// --------------- feilds -----------------
  static const routeName = '/electronic-courses-screen';

  const ElectronicCoursesScreen({super.key});

  @override
  State<ElectronicCoursesScreen> createState() => _ElectronicCoursesScreenState();
}

class _ElectronicCoursesScreenState extends State<ElectronicCoursesScreen> {
// --------------- state --------------

  bool _isLoading = true;
  var _bottomPadding = 0.0;
  List<dynamic> _courseGroups = [];
// --------------- lifecycle -----------------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    getAllCourseGroups();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

// --------------- methods -----------------
  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  Future<void> getAllCourseGroups() async {
    await Provider.of<ElectronicCourseProvider>(context, listen: false).fetchElectronicCourseGroups();
    if (mounted) {
      setState(() {
        _courseGroups = Provider.of<ElectronicCourseProvider>(context, listen: false).courseGroups;
        _isLoading = false;
      });
    }
  }

// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    final margin = MediaQuery.of(context).size.width * .200;
    final theme = Theme.of(context);
    return DefaultTabController(
      length: _courseGroups.length,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            toolbarHeight: 12,
            automaticallyImplyLeading: false,
            backgroundColor: theme.appBarTheme.backgroundColor,
            leading: null,
            bottom: TabBar(
              unselectedLabelColor: theme.appBarTheme.toolbarTextStyle!.color,
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontFamily: 'YekanBakh', fontSize: 12),
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'YekanBakh', fontSize: 14),
              isScrollable: true,
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              labelPadding: const EdgeInsets.symmetric(horizontal: 25),
              tabs: List.generate(
                _courseGroups.length,
                (index) => Tab(
                  text: _courseGroups[index]['name'],
                ),
              ),
            ),
          ),
          body: _isLoading
              ? const Center(child: Spinner(size: 35))
              : TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(
                    _courseGroups.length,
                    (index) {
                      final group = _courseGroups[index];
                      return NotificationListener<ScrollEndNotification>(
                        onNotification: (notification) {
                          setState(() {
                            _bottomPadding = notification.metrics.extentAfter == 0.0 ? margin : 0.0;
                          });
                          return true;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: _bottomPadding),
                          child: ElectronicCoursesList(
                            groupId: group['id'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
