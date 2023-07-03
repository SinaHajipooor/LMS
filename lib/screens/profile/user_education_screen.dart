import 'package:flutter/material.dart';
import 'package:lms/widgets/profile/job_info_form_modal.dart';

class UserEducationScreen extends StatefulWidget {
  static const routeName = '/user-education-screen';
  const UserEducationScreen({super.key});

  @override
  State<UserEducationScreen> createState() => _UserEducationScreenState();
}

class _UserEducationScreenState extends State<UserEducationScreen> {
  //---------------- state -------------------

  bool _checkAll = false;
  List<Map<String, String>> _data = [
    {'id': '001', 'device': 'Phone', 'operation': 'Call'},
    {'id': '002', 'device': 'Laptop', 'operation': 'Code'},
    {'id': '003', 'device': 'Tablet', 'operation': 'Play'},
    {'id': '004', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '005', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '006', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '007', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '008', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '009', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '009', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '009', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '009', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '009', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '009', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '009', 'device': 'Desktop', 'operation': 'Design'},
    {'id': '009', 'device': 'Desktop', 'operation': 'Design'},
  ];

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
  //---------------- UI -------------------

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text('اطلاعات تحصیلی', style: TextStyle(color: Colors.black, fontSize: 15)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(onPressed: () => _showJobinfoFormModal(context, deviceSize.height, 1), icon: const Icon(Icons.add, color: Colors.blue)),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  DataTable(
                    dividerThickness: 0.5,
                    horizontalMargin: 0,
                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade100),
                    dataRowHeight: 50,
                    columns: [
                      const DataColumn(label: Center(child: Text('مدرک‌تحصیلی', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                      const DataColumn(label: Center(child: Text('رشته‌تحصیلی', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                      const DataColumn(label: Center(child: Text('نوع‌دانشگاه‌محل‌اخذ‌مدرک', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                      const DataColumn(label: Center(child: Text('دانشگاه‌محل‌اخذ‌مدرک', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                      const DataColumn(label: Center(child: Text('عملیات', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))),
                      DataColumn(
                        label: Row(
                          children: [
                            const Text('انتخاب', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                            Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              value: _checkAll,
                              onChanged: (value) {
                                setState(() {
                                  _checkAll = value!;
                                  _data.forEach((item) {
                                    item['checked'] = value.toString();
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                    rows: _data.map((item) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(2, 0),
                                    ),
                                  ],
                                ),
                                child: Text(item['id']!, style: const TextStyle(fontSize: 12)),
                              ),
                            ),
                          ),
                          DataCell(Center(child: Text(item['device']!, style: const TextStyle(fontSize: 12)))),
                          DataCell(Center(child: Text(item['device']!, style: const TextStyle(fontSize: 12)))),
                          DataCell(Center(child: Text(item['device']!, style: const TextStyle(fontSize: 12)))),
                          DataCell(
                            PopupMenuButton(
                              icon: const Icon(Icons.more_vert, size: 19),
                              elevation: 2,
                              onSelected: (value) {
                                print(value);
                              },
                              itemBuilder: (BuildContext context) => [
                                const PopupMenuItem(
                                  child: SizedBox(
                                    width: 110,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          PopupMenuItem(
                                            value: 'edit',
                                            child: Icon(Icons.edit, color: Colors.orange, size: 20),
                                          ),
                                          PopupMenuItem(
                                            padding: EdgeInsets.only(left: 1),
                                            value: 'delete',
                                            child: Icon(Icons.delete, color: Colors.red, size: 20),
                                          ),
                                          PopupMenuItem(
                                            value: 'detail',
                                            child: Icon(Icons.file_copy_outlined, color: Colors.blue, size: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Checkbox(
                              value: item['checked'] == 'true',
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              onChanged: (value) {
                                setState(() {
                                  item['checked'] = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}