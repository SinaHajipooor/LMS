import 'package:flutter/material.dart';
import 'package:lms/helpers/InternetConnectivityHelper.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/providers/Profile/ActivityHistory/ActivityHistoryProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/profile/activities/activities_info.dart';
import 'package:lms/widgets/profile/activities/activities_info_modal.dart';
import 'package:provider/provider.dart';

class ActivitiesInfoScreen extends StatefulWidget {
  static const routeName = '/activities-info-screen';
  const ActivitiesInfoScreen({super.key});

  @override
  State<ActivitiesInfoScreen> createState() => _ActivitiesInfoScreenState();
}

class _ActivitiesInfoScreenState extends State<ActivitiesInfoScreen> {
  // ----------- state -------------
  bool _isLoading = true;
  // ----------- lifecycle -------------

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    fetchAllActivities();
    super.initState();
  }

  // --------------- methods -----------------
  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  Future<void> fetchAllActivities() async {
    await Provider.of<ActivityHistoryProvider>(context, listen: false).fetchAllActivities();
    setState(() {
      _isLoading = false;
    });
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
        return ActivitiesInfoModal(deviceHeight: deviceHeight);
      },
    );
  }

  //---------------- UI -------------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text('سوابق فعالیت‌ها و تجارب', style: theme.textTheme.titleMedium),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.iconTheme!.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(onPressed: () => _showJobinfoFormModal(context, deviceSize.height, 1), icon: Icon(Icons.add, color: themeMode == ThemeMode.light ? Colors.blue : Colors.white)),
        ],
      ),
      body: _isLoading
          ? const Center(child: Spinner(size: 35))
          : ActivitiesInfo(
              // activitesList: Provider.of<ActivityHistoryProvider>(context, listen: false).activities,
              ),
    );
  }
}