import 'package:flutter/material.dart';
import 'package:lms/helpers/InternetConnectivityHelper.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/providers/Profile/Job/JobProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/profile/job/job_info.dart';
import 'package:lms/widgets/profile/user/job_info_form_modal.dart';
import 'package:provider/provider.dart';

class UserJobScreen extends StatefulWidget {
  static const routeName = '/user-job-info-screen';
  const UserJobScreen({super.key});

  @override
  State<UserJobScreen> createState() => _UserJobScreenState();
}

class _UserJobScreenState extends State<UserJobScreen> {
  //--------------- state -------------------
  bool _isLoading = true;
  List<dynamic> jobs = [];
//---------------- lifecycle -----------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    super.initState();
  }
  //--------------- methods -------------------

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

  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  Future<void> fetchAllJobs() async {
    await Provider.of<JobProvider>(context, listen: false).fetchAllJobs();
    setState(() {
      jobs = Provider.of<JobProvider>(context, listen: false).jobs;
      _isLoading = false;
    });
  }

  Future<void> deleteJob(int jobId, int index) async {
    final jobsCopy = List.from(jobs);
    jobsCopy.removeAt(index);
    await Provider.of<JobProvider>(context, listen: false).deleteJob(jobId);
    setState(() {
      jobs = jobsCopy;
    });
    setState(() {});
  }
  //--------------- UI -------------------

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text('اطلاعات شغلی', style: theme.textTheme.titleMedium),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.iconTheme!.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [IconButton(onPressed: () => _showJobinfoFormModal(context, deviceSize.height, 2), icon: Icon(Icons.add, color: themeMode == ThemeMode.light ? Colors.blue : Colors.white))],
      ),
      body: _isLoading
          ? const Center(child: Spinner(size: 35))
          : JobInfo(
              deleteJob: deleteJob,
              fetchAllJobs: fetchAllJobs,
              jobs: jobs,
            ),
    );
  }
}
