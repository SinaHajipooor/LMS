import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/helpers/Theme/theme_helper.dart';
import 'package:lms/widgets/profile/job/job_modal.dart';
import 'package:provider/provider.dart';

class JobInfo extends StatefulWidget {
  final List jobs;
  final Function() fetchAllJobs;
  final Function(int jobId, int index) deleteJob;
  const JobInfo({super.key, required this.jobs, required this.fetchAllJobs, required this.deleteJob});

  @override
  State<JobInfo> createState() => _JobInfoState();
}

class _JobInfoState extends State<JobInfo> {
  // -------------- methods ---------------

  _showJobModal(
    BuildContext context,
    int jobId,
    int useCase,
  ) {
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
        return JobModal(
          fetchAllJobs: widget.fetchAllJobs,
          deviceHeight: MediaQuery.of(context).size.height,
          title: useCase == 1 ? 'ویرایش اطلاعات شغلی' : 'جزئیات اطلاعات شغلی',
          jobId: jobId,
          isEditing: useCase == 1,
          isShowing: useCase == 2,
          isCreating: false,
        );
      },
    );
  }

  // -------------- UI ---------------
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    final theme = Theme.of(context).textTheme;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.jobs.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: themeMode == ThemeMode.dark ? Theme.of(context).scaffoldBackgroundColor : Colors.grey[300],
              child: Text((index + 1).toString()),
            ),
            title: Text(
              widget.jobs[index]['title'] ?? '',
              style: theme.bodyMedium!.copyWith(fontSize: 14),
            ),
            subtitle: Text(widget.jobs[index]['position'] ?? '', style: theme.bodySmall!.copyWith(fontSize: 11)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => _showJobModal(context, widget.jobs[index]['id'], 1),
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 15,
                    child: Image.asset(
                      'assets/images/icons/edit2.png',
                      color: Colors.white,
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () => widget.deleteJob(widget.jobs[index]['id'], index),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red,
                    child: Image.asset(
                      'assets/images/icons/delete.png',
                      width: 18,
                      height: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
