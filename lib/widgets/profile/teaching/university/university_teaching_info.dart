import 'package:flutter/material.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/widgets/profile/teaching/university/university_teaching_modal.dart';
import 'package:provider/provider.dart';

class UniversityTeachingInfo extends StatefulWidget {
  final List<dynamic> universityTeachings;
  final Function() fetchAllUniversityTeachings;
  final Function(int id, int index) deleteUniversityTeaching;
  const UniversityTeachingInfo({
    super.key,
    required this.universityTeachings,
    required this.fetchAllUniversityTeachings,
    required this.deleteUniversityTeaching,
  });

  @override
  State<UniversityTeachingInfo> createState() => _UniversityTeachingInfoState();
}

class _UniversityTeachingInfoState extends State<UniversityTeachingInfo> {
  // // --------------- methods -----------------

  _showUniversityTeachingModal(
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
        return UniversityTeachingModal(
          fetchAllUniversityTeachings: widget.fetchAllUniversityTeachings,
          deviceHeight: MediaQuery.of(context).size.height,
          title: useCase == 1 ? 'ویرایش سوابق تدریس دانشگاهی' : 'جزئیات سوابق تدریس دانشگاهی',
          universityTeachingId: activityId,
          isEditing: useCase == 1,
          isShowing: useCase == 2,
          isCreating: false,
        );
      },
    );
  }

  // --------------- UI -----------------

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    final theme = Theme.of(context).textTheme;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.universityTeachings.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: ListTile(
            onTap: () => _showUniversityTeachingModal(context, widget.universityTeachings[index]['id'], 2),
            leading: CircleAvatar(
              backgroundColor: themeMode == ThemeMode.dark ? Theme.of(context).scaffoldBackgroundColor : Colors.grey[300],
              child: Text((index + 1).toString()),
            ),
            title: Text(
              widget.universityTeachings[index]['title'],
              style: theme.bodyMedium!.copyWith(fontSize: 14),
            ),
            subtitle: Text(widget.universityTeachings[index]['academic_field'], style: theme.bodySmall!.copyWith(fontSize: 11)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => _showUniversityTeachingModal(context, widget.universityTeachings[index]['id'], 1),
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
                  onTap: () => widget.deleteUniversityTeaching(widget.universityTeachings[index]['id'], index),
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
