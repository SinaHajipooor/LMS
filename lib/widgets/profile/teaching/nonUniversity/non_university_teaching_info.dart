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

  // @override
  // Widget build(BuildContext context) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     physics: const BouncingScrollPhysics(),
  //     child: Card(
  //       elevation: 0,
  //       child: DataTable(
  //         dividerThickness: 0.5,
  //         horizontalMargin: 0,
  //         headingRowColor: MaterialStateColor.resolveWith((states) => Theme.of(context).appBarTheme.backgroundColor!),
  //         dataRowHeight: 50,
  //         columns: const [
  //           DataColumn(label: Center(child: Text('عنوان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('مطالب ارائه شده', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('زمان شروع', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('زمان پایان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('فعالیت جاری', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //           DataColumn(label: Center(child: Text('نمایش', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
  //         ],
  //         rows: List<DataRow>.generate(
  //           widget.nonUniversityTeachings.length,
  //           (index) => DataRow(cells: [
  //             DataCell(Center(child: Text(widget.nonUniversityTeachings[index]['title'] ?? ''))),
  //             DataCell(Center(child: Text(widget.nonUniversityTeachings[index]['activity_description'] ?? ''))),
  //             DataCell(Center(child: Text(widget.nonUniversityTeachings[index]['start_date'] ?? ''))),
  //             DataCell(Center(child: Text(widget.nonUniversityTeachings[index]['end_date'] ?? ''))),
  //             DataCell(Center(child: Text(widget.nonUniversityTeachings[index]['is_current'] == false ? 'خیر' : 'بلی'))),
  //             DataCell(Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 CircleAvatar(
  //                   backgroundColor: Colors.orange,
  //                   radius: 15,
  //                   child: IconButton(
  //                     icon: const Icon(Icons.edit, color: Colors.white, size: 15),
  //                     onPressed: () => _showNonUniversityTeachingModal(context, widget.nonUniversityTeachings[index]['id'], 1),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 4),
  //                 CircleAvatar(
  //                   radius: 15,
  //                   backgroundColor: Colors.red,
  //                   child: Center(child: IconButton(icon: const Icon(Icons.delete, color: Colors.white, size: 15), onPressed: () => widget.deleteNonUniversityTeaching(widget.nonUniversityTeachings[index]['id'], index))),
  //                 ),
  //               ],
  //             )),
  //             DataCell(
  //               IconButton(
  //                 icon: const Icon(Icons.remove_red_eye, color: Colors.orange, size: 20),
  //                 onPressed: () => _showNonUniversityTeachingModal(context, widget.nonUniversityTeachings[index]['id'], 2),
  //               ),
  //             )
  //           ]),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    final theme = Theme.of(context).textTheme;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.nonUniversityTeachings.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: themeMode == ThemeMode.dark ? Theme.of(context).cardTheme.color : Colors.grey[300],
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
              CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 15,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white, size: 15),
                  onPressed: () => _showNonUniversityTeachingModal(context, widget.nonUniversityTeachings[index]['id'], 1),
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () => widget.deleteNonUniversityTeaching(widget.nonUniversityTeachings[index]['id'], index),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white, size: 15),
                      onPressed: () => widget.deleteNonUniversityTeaching(widget.nonUniversityTeachings[index]['id'], index),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
