import 'package:flutter/material.dart';
import 'package:lms/helpers/connections/internet_connectivity_helper.dart';
import 'package:lms/helpers/theme/theme_helper.dart';
import 'package:lms/providers/Profile/PassedCourses/InternalPassedCoursesProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/profile/passedCourses/internal/internal_passed_courses_info.dart';
import 'package:lms/widgets/profile/user/job_info_form_modal.dart';
import 'package:provider/provider.dart';

class InternalPassedCoursesScreen extends StatefulWidget {
  static const routeName = '/internal-passed-courses-screen';
  const InternalPassedCoursesScreen({super.key});

  @override
  State<InternalPassedCoursesScreen> createState() => _InternalPassedCoursesScreenState();
}

class _InternalPassedCoursesScreenState extends State<InternalPassedCoursesScreen> {
  // ----------- state -------------
  List<dynamic> internalPassedCourses = [];
  bool _isLoading = true;
  // ----------- lifecycle -------------

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    fetchAllInternalPassedCourses();
    super.initState();
  }

  // --------------- methods -----------------
  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  _showJobinfoFormModal(BuildContext context, double deviceHeight, int selectedIndex) {
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
        return UserInfoFormModal(deviceHeight: deviceHeight, selectedIndex: selectedIndex);
      },
    );
  }

  Future<void> fetchAllInternalPassedCourses() async {
    await Provider.of<InternalPassedCoursesProvider>(context, listen: false).fetchAllInternalPassedCourses();
    setState(() {
      internalPassedCourses = Provider.of<InternalPassedCoursesProvider>(context, listen: false).internalPassedCourses;
      _isLoading = false;
    });
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
        title: Text('دوره‌های گذرانده شده در مرکز', style: theme.textTheme.titleMedium),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.iconTheme!.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(onPressed: () => _showJobinfoFormModal(context, deviceSize.height, 1), icon: Icon(Icons.add, color: themeMode == ThemeMode.light ? Colors.blue : Colors.white)),
        ],
      ),
      body: _isLoading ? const Center(child: Spinner(size: 35)) : const InternalPassedCoursesInfo(),
    );
  }
}
