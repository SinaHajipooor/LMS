import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/helpers/theme/theme_helper.dart';
import 'package:lms/widgets/profile/activities/activities_info_modal.dart';
import 'package:provider/provider.dart';

class ActivitiesInfo extends StatefulWidget {
  final List activities;
  final Function() fetchAllActivities;
  final Function(int id, int index) deleteActivity;
  const ActivitiesInfo({
    super.key,
    required this.activities,
    required this.fetchAllActivities,
    required this.deleteActivity,
  });

  @override
  State<ActivitiesInfo> createState() => _ActivitiesInfoState();
}

class _ActivitiesInfoState extends State<ActivitiesInfo> {
  // -------------- methods ---------------
  void showInputDialog(int activityId, int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text('این مورد را حذف می‌کنید ؟', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15)),
      ),
      btnOk: ElevatedButton(
        onPressed: () {
          widget.deleteActivity(activityId, index);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        child: const Text('حذف'),
      ),
      btnCancel: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        child: const Text('لغو'),
      ),
    ).show();
  }

  _showActivityModal(
    BuildContext context,
    int activityId,
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
        return ActivitiesInfoModal(
          fetchAllActivities: widget.fetchAllActivities,
          deviceHeight: MediaQuery.of(context).size.height,
          title: useCase == 1 ? 'ویرایش فعالیت‌ها و تجارب' : 'جزئیات فعالیت‌ها و تجارب',
          activityId: activityId,
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
      itemCount: widget.activities.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: ListTile(
            onTap: () => _showActivityModal(context, widget.activities[index]['id'], 2),
            leading: CircleAvatar(
              backgroundColor: themeMode == ThemeMode.dark ? Theme.of(context).scaffoldBackgroundColor : Colors.grey[300],
              child: Text((index + 1).toString()),
            ),
            title: Text(
              widget.activities[index]['title'],
              style: theme.bodyMedium!.copyWith(fontSize: 14),
            ),
            subtitle: Text(widget.activities[index]['position'], style: theme.bodySmall!.copyWith(fontSize: 11)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => _showActivityModal(context, widget.activities[index]['id'], 1),
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
                  // onTap: () => widget.deleteActivity(widget.activities[index]['id'], index),
                  onTap: () => showInputDialog(widget.activities[index]['id'], index),
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
