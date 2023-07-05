import 'package:flutter/material.dart';

class PresenceList extends StatefulWidget {
  const PresenceList({Key? key}) : super(key: key);
  @override
  State<PresenceList> createState() => _PresenceListState();
}

class _PresenceListState extends State<PresenceList> {
  List<Student> students = [
    Student(name: 'سیناحاجی‌پور', nationalCode: '1234567890'),
    Student(name: 'محمد علی عباس', nationalCode: '0987654321'),
    Student(name: 'رضا محمدنزاد', nationalCode: '0987654321'),
    Student(name: 'عباس علی نژاد', nationalCode: '0987654321'),
    Student(name: 'زهرا رضایی', nationalCode: '0987654321'),
    Student(name: 'مینو سلامی', nationalCode: '0987654321'),
    Student(name: 'محمد محمدآبادی', nationalCode: '0987654321'),
    Student(name: 'رسول الله فاطمی', nationalCode: '0987654321'),
    Student(name: 'محمد ابراهیمی', nationalCode: '0987654321'),
    Student(name: 'ساسان نظری', nationalCode: '0987654321'),
  ];
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemCount: students.length,
      itemBuilder: (context, index) {
        return Container(
          margin: index == students.length - 1 ? const EdgeInsets.only(bottom: 180) : null,
          child: Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            child: Column(
              children: [
                ListTile(
                  leading: ClipOval(
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey,
                      child: Image.asset('assets/images/avatar.png', fit: BoxFit.cover),
                    ),
                  ),
                  title: Text(
                    students[index].name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  subtitle: Text(
                    students[index].nationalCode,
                    style: const TextStyle(fontSize: 13),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('حاضر', style: TextStyle(fontSize: 12)),
                      Radio<bool>(
                        value: true,
                        groupValue: students[index].isPresent,
                        onChanged: (value) {
                          setState(() {
                            students[index].isPresent = value!;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text('غایب', style: TextStyle(fontSize: 12)),
                      Radio<bool>(
                        value: false,
                        groupValue: students[index].isPresent,
                        onChanged: (value) {
                          setState(() {
                            students[index].isPresent = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: (deviceSize.width / 10) * 8,
                        child: const TextField(
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: 'توضیحات',
                            labelStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.only(right: 10),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: deviceSize.width / 10,
                        child: const TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'تاخیر',
                            labelStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.only(right: 10),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(strokeAlign: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Student {
  final String name;
  final String nationalCode;
  bool isPresent;
  Student({required this.name, required this.nationalCode, this.isPresent = true});
}
