import 'package:flutter/material.dart';
import 'package:lms/providers/Profile/Teaching/NonUniversityTeachingProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/profile/teaching/nonUniversity/non_university_teaching_modal.dart';
import 'package:provider/provider.dart';

class NonUniversityTeachingInfo extends StatefulWidget {
  const NonUniversityTeachingInfo({super.key});

  @override
  State<NonUniversityTeachingInfo> createState() => _NonUniversityTeachingInfoState();
}

class _NonUniversityTeachingInfoState extends State<NonUniversityTeachingInfo> {
  // --------------- state -----------------
  bool _isLoading = true;
  List<dynamic> nonUniversityTeachings = [];
  // --------------- lifecycle -----------------
  @override
  void didChangeDependencies() {
    fetchAllNonUniversityTeachings();
    super.didChangeDependencies();
  }
  // --------------- methods -----------------

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

  Future<void> fetchAllNonUniversityTeachings() async {
    await Provider.of<NonUniversityTeachingProvider>(context, listen: false).fetchAllNonUniversityTeachings();
    setState(() {
      nonUniversityTeachings = Provider.of<NonUniversityTeachingProvider>(context, listen: false).nonUniversityTeachings;
      _isLoading = false;
    });
  }

  Future<void> deleteNonUniversityTeaching(int nonUniversityTeachingId, int index) async {
    Navigator.of(context).pop();
    final universityTeachingsCopy = List.from(nonUniversityTeachings);
    universityTeachingsCopy.removeAt(index);
    await Provider.of<NonUniversityTeachingProvider>(context, listen: false).deleteNonUniversityTeaching(nonUniversityTeachingId);
    setState(() {
      nonUniversityTeachings = universityTeachingsCopy;
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
                  DataColumn(label: Center(child: Text('مطالب ارائه شده', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('زمان شروع', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('زمان پایان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('فعالیت جاری', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('نمایش', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                ],
                rows: List<DataRow>.generate(
                  nonUniversityTeachings.length,
                  (index) => DataRow(cells: [
                    DataCell(Center(child: Text(nonUniversityTeachings[index]['title'] ?? ''))),
                    DataCell(Center(child: Text(nonUniversityTeachings[index]['activity_description'] ?? ''))),
                    DataCell(Center(child: Text(nonUniversityTeachings[index]['start_date'] ?? ''))),
                    DataCell(Center(child: Text(nonUniversityTeachings[index]['end_date'] ?? ''))),
                    DataCell(Center(child: Text(nonUniversityTeachings[index]['is_current'] == false ? 'خیر' : 'بلی'))),
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
                                    onPressed: () => _showNonUniversityTeachingModal(context, nonUniversityTeachings[index]['id'], 1),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.red,
                                  child: IconButton(icon: const Icon(Icons.delete, color: Colors.white, size: 15), onPressed: () => deleteNonUniversityTeaching(nonUniversityTeachings[index]['id'], index)),
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
                        onPressed: () => {},
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
  }
}
