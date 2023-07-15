import 'package:flutter/material.dart';
import 'package:lms/providers/Profile/Compilations/CompilationsProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/profile/compilations/compilations_modal.dart';
import 'package:provider/provider.dart';

class CompilationsInfo extends StatefulWidget {
  const CompilationsInfo({super.key});

  @override
  State<CompilationsInfo> createState() => _CompilationsInfoState();
}

class _CompilationsInfoState extends State<CompilationsInfo> {
  // -------------- state ---------------
  bool _isLoading = true;
  List<dynamic> compilations = [];
  // -------------- lifecycle ---------------
  @override
  void didChangeDependencies() {
    fetchAllCompilations();
    super.didChangeDependencies();
  }

  // -------------- methods ---------------
  _showCompilationsModal(
    BuildContext context,
    int compilationId,
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
        return CompilationsModal(
          deviceHeight: MediaQuery.of(context).size.height,
          title: useCase == 1 ? 'ویرایش تالیفات و ترجیمات' : 'جزئیات تالیفات و ترجمات',
          compilationId: compilationId,
          isEditing: useCase == 1,
          isShowing: useCase == 2,
          isCreating: false,
        );
      },
    );
  }

  Future<void> fetchAllCompilations() async {
    await Provider.of<CompilationsProvider>(context, listen: false).fetchAllCompilations();
    setState(() {
      compilations = Provider.of<CompilationsProvider>(context, listen: false).compilations;
      _isLoading = false;
    });
  }

  Future<void> deleteCompilation(int compilationId, int index) async {
    Navigator.of(context).pop();
    final compilationCopy = List.from(compilations);
    compilationCopy.removeAt(index);
    await Provider.of<CompilationsProvider>(context, listen: false).deleteCompilation(compilationId);
    setState(() {
      compilations = compilationCopy;
    });
  }

  // -------------- UI ---------------

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: Spinner(size: 35))
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Card(
              elevation: 1,
              child: DataTable(
                dividerThickness: 0.5,
                horizontalMargin: 0,
                headingRowColor: MaterialStateColor.resolveWith((states) => Theme.of(context).appBarTheme.backgroundColor!),
                dataRowHeight: 50,
                columns: const [
                  DataColumn(label: Center(child: Text('عنوان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('نوع تالیف', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('زبان', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('مرکز انتشار', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('سال انتشار', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('فعالیت مرتبط', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                  DataColumn(label: Center(child: Text('انتخاب', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                ],
                rows: List<DataRow>.generate(
                  compilations.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(Center(child: Text(compilations[index]['title'] ?? ''))),
                      DataCell(Center(child: Text(compilations[index]['title'] ?? ''))),
                      DataCell(Center(child: Text(compilations[index]['title'] ?? ''))),
                      DataCell(Center(child: Text(compilations[index]['title'] ?? ''))),
                      DataCell(Center(child: Text(compilations[index]['title'] ?? ''))),
                      DataCell(Center(child: Text(compilations[index]['title'] ?? ''))),
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
                                      onPressed: () => _showCompilationsModal(context, compilations[index]['id'], 1),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.red,
                                    child: IconButton(icon: const Icon(Icons.delete, color: Colors.white, size: 15), onPressed: () => deleteCompilation(compilations[index]['id'], index)),
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
                        IconButton(icon: const Icon(Icons.remove_red_eye, color: Colors.orange, size: 20), onPressed: () => _showCompilationsModal(context, compilations[index]['id'], 2)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
