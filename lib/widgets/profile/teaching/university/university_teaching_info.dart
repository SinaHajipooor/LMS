import 'package:flutter/material.dart';
import 'package:lms/providers/Profile/Teaching/UniversityTeachingProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/profile/teaching/university/university_teaching_modal.dart';
import 'package:provider/provider.dart';

class UniversityTeachingInfo extends StatefulWidget {
  const UniversityTeachingInfo({super.key});

  @override
  State<UniversityTeachingInfo> createState() => _UniversityTeachingInfoState();
}

class _UniversityTeachingInfoState extends State<UniversityTeachingInfo> {
  // --------------- state -----------------
  bool _isLoading = true;
  List<dynamic> universityTeachings = [];
  // --------------- lifecycle -----------------
  @override
  void didChangeDependencies() {
    fetchAllUniversityTeachings();
    super.didChangeDependencies();
  }
  // --------------- methods -----------------

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

  Future<void> fetchAllUniversityTeachings() async {
    await Provider.of<UniversityTeachingProvider>(context, listen: false).fetchAllUniversityTeachings();
    setState(() {
      universityTeachings = Provider.of<UniversityTeachingProvider>(context, listen: false).universityTeachings;
      _isLoading = false;
    });
  }

  Future<void> deleteUniversityTeaching(int universityTeachingId, int index) async {
    Navigator.of(context).pop();
    final universityTeachingsCopy = List.from(universityTeachings);
    universityTeachingsCopy.removeAt(index);
    await Provider.of<UniversityTeachingProvider>(context, listen: false).deleteUniversityTeaching(universityTeachingId);
    setState(() {
      universityTeachings = universityTeachingsCopy;
    });
  }

  // --------------- UI -----------------

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: Spinner(size: 35))
        : SingleChildScrollView(
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
                  DataColumn(label: Center(child: Text('مقطع تحصیلی', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('زمان شروع', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('زمان پایان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('فعالیت جاری', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('نمایش', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                ],
                rows: List<DataRow>.generate(
                  universityTeachings.length,
                  (index) => DataRow(cells: [
                    DataCell(Center(child: Text(universityTeachings[index]['title'] ?? ''))),
                    DataCell(Center(child: Text(universityTeachings[index]['academic_field'] ?? ''))),
                    DataCell(Center(child: Text(universityTeachings[index]['start_date'] ?? ''))),
                    DataCell(Center(child: Text(universityTeachings[index]['end_date'] ?? ''))),
                    DataCell(Center(child: Text(universityTeachings[index]['is_current'] == false ? 'خیر' : 'بلی'))),
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
                                    onPressed: () => _showUniversityTeachingModal(context, universityTeachings[index]['id'], 1),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.red,
                                  child: IconButton(icon: const Icon(Icons.delete, color: Colors.white, size: 15), onPressed: () => deleteUniversityTeaching(universityTeachings[index]['id'], index)),
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
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye, color: Colors.orange, size: 20),
                        onPressed: () => _showUniversityTeachingModal(context, universityTeachings[index]['id'], 2),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
  }
}
