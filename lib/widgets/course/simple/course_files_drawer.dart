import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/widgets/course/simple/student_files_form.dart';
import 'package:provider/provider.dart';

class CourseFilesDrawer extends StatefulWidget {
  const CourseFilesDrawer({super.key});

  @override
  State<CourseFilesDrawer> createState() => _CourseFilesDrawerState();
}

class _CourseFilesDrawerState extends State<CourseFilesDrawer> {
  bool _isExpanded = false;

  void showInputDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: StudentFilesForm(),
      ),
      btnOk: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        child: const Text('ذخیره'),
      ),
      btnCancel: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        child: const Text('لغو'),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeModel>(context).themeMode;

    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Card(
        elevation: 0.5,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 680),
          curve: Curves.easeInOut,
          height: _isExpanded ? 190 : 60,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 10, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'فایل ها',
                              style: TextStyle(
                                color: _isExpanded ? Colors.blue : (themeMode == ThemeMode.dark ? Colors.white : Colors.black),
                                fontSize: _isExpanded ? 16.0 : 15,
                                fontWeight: _isExpanded ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                              child: Icon(_isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_left, size: 25.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 1.0),
                      Expanded(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: _isExpanded ? 1.0 : 0.0,
                          child: ListView(
                            padding: const EdgeInsets.only(top: 30, bottom: 0),
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color.fromARGB(255, 180, 179, 179),
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                      title: Text(
                                        'فایل های دستگاه اجرایی',
                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal),
                                      ),
                                      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye, color: Colors.orange))),
                                ),
                              ),
                              InkWell(
                                onTap: () => showInputDialog(),
                                child: ListTile(
                                  title: Text('فایل های فراگیر', style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
                                  trailing: IconButton(
                                    onPressed: () => showInputDialog(),
                                    icon: const Icon(Icons.upload_file, color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
