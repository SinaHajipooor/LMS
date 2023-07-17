import 'package:flutter/material.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/widgets/profile/teaching/nonUniversity/non_university_teaching_modal.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NonUniversityTeachingInfo extends StatefulWidget {
  final List<dynamic> nonUniversityTeachings;
  final Function(int id, int index) deleteNonUniversityTeaching;
  final Function() fetchAllNonUniversityTeachings;
  const NonUniversityTeachingInfo({super.key, required this.nonUniversityTeachings, required this.deleteNonUniversityTeaching, required this.fetchAllNonUniversityTeachings});

  @override
  State<NonUniversityTeachingInfo> createState() => _NonUniversityTeachingInfoState();
}

class _NonUniversityTeachingInfoState extends State<NonUniversityTeachingInfo> {
  // // --------------- methods -----------------

  _showNonUniversityTeachingModal(
    BuildContext context,
    int nonUniversityTeachingId,
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
        return NonUniversityTeachingModal(
          fetchAllNonUniversityTeachings: widget.fetchAllNonUniversityTeachings,
          deviceHeight: MediaQuery.of(context).size.height,
          title: useCase == 1 ? 'ویرایش سوابق تدریس غیر دانشگاهی' : 'جزئیات سوابق تدریس غیر دانشگاهی',
          nonUniversityTeachingId: nonUniversityTeachingId,
          isEditing: useCase == 1,
          isShowing: useCase == 2,
          isCreating: false,
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  // --------------- UI -----------------

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    final theme = Theme.of(context).textTheme;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.nonUniversityTeachings.length,
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
              widget.nonUniversityTeachings[index]['title'],
              style: theme.bodyMedium!.copyWith(fontSize: 14),
            ),
            subtitle: Text(widget.nonUniversityTeachings[index]['activity_description'], style: theme.bodySmall!.copyWith(fontSize: 11)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => _showNonUniversityTeachingModal(context, widget.nonUniversityTeachings[index]['id'], 1),
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
                  onTap: () => widget.deleteNonUniversityTeaching(widget.nonUniversityTeachings[index]['id'], index),
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
