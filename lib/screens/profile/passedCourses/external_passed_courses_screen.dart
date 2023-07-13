import 'package:flutter/material.dart';
import 'package:lms/helpers/InternetConnectivityHelper.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/providers/Profile/PassedCourses/ExternalPassedCoursesProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/profile/passedCourses/external/external_passed_courses_info.dart';
import 'package:lms/widgets/profile/passedCourses/external/external_passed_courses_modal.dart';
import 'package:lms/widgets/profile/passedCourses/new/external_course_create_modal.dart';
import 'package:provider/provider.dart';

class ExternalPassedCoursesScreen extends StatefulWidget {
  static const routeName = '/external-passed-courses-screen';
  const ExternalPassedCoursesScreen({super.key});

  @override
  State<ExternalPassedCoursesScreen> createState() => _ExternalPassedCoursesScreenState();
}

class _ExternalPassedCoursesScreenState extends State<ExternalPassedCoursesScreen> {
  // ----------- state -------------
  bool _isLoading = true;
  // ----------- lifecycle -------------

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    fetchAllExternalCourses();
    super.initState();
  }

  // --------------- methods -----------------

  Future<void> fetchAllExternalCourses() async {
    await Provider.of<ExternalPassedCoursesProvider>(context, listen: false).fetchAllExternalCourses();
    setState(() {
      _isLoading = false;
    });
  }

  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  _showExternalCourseFormModal(BuildContext context, double deviceHeight, int selectedIndexm) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ExternalCourseCreateModal();
      },
    );
  }

  //---------------- UI -------------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text('دوره‌های گذرانده شده خارج مرکز', style: theme.textTheme.titleMedium),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.iconTheme!.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(onPressed: () => _showExternalCourseFormModal(context, deviceSize.height, 1), icon: Icon(Icons.add, color: themeMode == ThemeMode.light ? Colors.blue : Colors.white)),
        ],
      ),
      body: _isLoading
          ? const Center(child: Spinner(size: 35))
          : ExternalPassedCoursesInfo(
              externalCourses: Provider.of<ExternalPassedCoursesProvider>(context, listen: false).externalCourses,
            ),
    );
  }
}
