import 'package:flutter/material.dart';
import 'package:lms/widgets/profile/activities/activities_info_modal.dart';

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
  // -------------- state ---------------
  // bool _isLoading = false;
  // List<dynamic> activities = [];
  // -------------- lifecycle ---------------
  // @override
  // void didChangeDependencies() {
  //   fetchAllActivities();
  //   super.didChangeDependencies();
  // }

  // -------------- methods ---------------

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

  // Future<void> fetchAllActivities() async {
  //   await Provider.of<ActivityHistoryProvider>(context, listen: false).fetchAllActivities();
  //   setState(() {
  //     activities = Provider.of<ActivityHistoryProvider>(context, listen: false).activities;
  //     _isLoading = false;
  //   });
  // }

  // Future<void> deleteActivity(int activityId, int index) async {
  //   Navigator.of(context).pop();
  //   final activitiesCopy = List.from(activities);
  //   activitiesCopy.removeAt(index);
  //   await Provider.of<ActivityHistoryProvider>(context, listen: false).deleteActivity(activityId);
  //   setState(() {
  //     activities = activitiesCopy;
  //   });
  // }
  // -------------- UI ---------------

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Card(
        elevation: 0,
        child: DataTable(
          dividerThickness: 0.5,
          horizontalMargin: 0,
          headingRowColor: MaterialStateColor.resolveWith((states) => Theme.of(context).appBarTheme.backgroundColor!),
          dataRowHeight: 50,
          columns: const [
            DataColumn(label: Center(child: Text('عنوان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('آدرس', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('سمت', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('زمان شروع', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('زمان پایان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('فعالیت جاری', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('نوع همکاری', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
            DataColumn(label: Center(child: Text('نمایش', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
          ],
          rows: List<DataRow>.generate(
            widget.activities.length,
            (index) => DataRow(
              cells: [
                DataCell(Center(child: Text(widget.activities[index]['title'] ?? ''))),
                DataCell(Center(child: Text(widget.activities[index]['address'] ?? ''))),
                DataCell(Center(child: Text(widget.activities[index]['position'] ?? ''))),
                DataCell(Center(child: Text(widget.activities[index]['start_date'] ?? ''))),
                DataCell(Center(child: Text(widget.activities[index]['end_date'] ?? ''))),
                DataCell(Center(child: Text(widget.activities[index]['current_position'] == false ? 'خیر' : 'بلی'))),
                DataCell(Center(child: Text(widget.activities[index]['work_type'] ?? ''))),
                DataCell(
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert, size: 19),
                    elevation: 2,
                    onSelected: (value) {
                      print(value);
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                          child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 8,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 15,
                              child: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white, size: 15),
                                onPressed: () => _showActivityModal(context, widget.activities[index]['id'], 1),
                              ),
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.red,
                              child: IconButton(icon: const Icon(Icons.delete, color: Colors.white, size: 15), onPressed: () => widget.deleteActivity(widget.activities[index]['id'], index)),
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.blue,
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(Icons.file_copy_outlined, color: Colors.white, size: 15),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                DataCell(
                  IconButton(icon: const Icon(Icons.remove_red_eye, color: Colors.orange, size: 20), onPressed: () => _showActivityModal(context, widget.activities[index]['id'], 2)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
