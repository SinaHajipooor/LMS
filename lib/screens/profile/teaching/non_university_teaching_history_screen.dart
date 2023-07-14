import 'package:flutter/material.dart';
import 'package:lms/helpers/InternetConnectivityHelper.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/widgets/profile/teaching/nonUniversity/non_university_teaching_info.dart';
import 'package:lms/widgets/profile/teaching/nonUniversity/non_university_teaching_modal.dart';
import 'package:provider/provider.dart';

class NonUniversityTeachingHistoryScreen extends StatefulWidget {
  static const routeName = '/non-university-teaching-history-screen';
  const NonUniversityTeachingHistoryScreen({super.key});

  @override
  State<NonUniversityTeachingHistoryScreen> createState() => _NonUniversityTeachingHistoryScreenState();
}

class _NonUniversityTeachingHistoryScreenState extends State<NonUniversityTeachingHistoryScreen> {
  // ----------- lifecycle -------------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    super.initState();
  }

  // --------------- methods -----------------
  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  _showNonUniversityTeachingModal(BuildContext context, double deviceHeight, int selectedIndex) {
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
        return NonUniversityTeachingModal(
          deviceHeight: deviceHeight,
          isCreating: true,
          isEditing: false,
          isShowing: false,
          title: 'ایجاد سوابق تدریس غیر دانشگاهی',
        );
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
        title: Text('سوابق تدریس غیر دانشگاهی', style: theme.textTheme.titleMedium),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.iconTheme!.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(onPressed: () => _showNonUniversityTeachingModal(context, deviceSize.height, 1), icon: Icon(Icons.add, color: themeMode == ThemeMode.light ? Colors.blue : Colors.white)),
        ],
      ),
      body: const NonUniversityTeachingInfo(),
    );
  }
}
