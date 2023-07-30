import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/helpers/theme_helper.dart';
import 'package:lms/widgets/course/simple/course_meeting_details.dart';
import 'package:provider/provider.dart';

class SimpleCourseMeetings extends StatefulWidget {
  final List meetings;
  const SimpleCourseMeetings({super.key, required this.meetings});

  @override
  State<SimpleCourseMeetings> createState() => _SimpleCourseMeetingsState();
}

class _SimpleCourseMeetingsState extends State<SimpleCourseMeetings> {
  void showInputDialog(Map<String, dynamic> meeting) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(physics: const BouncingScrollPhysics(), child: CourseMeetingDetails(meeting: meeting)),
      btnOk: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        child: const Text('متوجه شدم'),
      ),
    ).show();
  }

  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;

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
          height: _isExpanded ? 290 : 60,
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
                              'جلسات',
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
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(top: 10, bottom: 5),
                            shrinkWrap: true,
                            itemCount: widget.meetings.length,
                            itemBuilder: (ctx, i) {
                              final meeting = widget.meetings[i];
                              return Container(
                                decoration: widget.meetings.length == i + 1
                                    ? null
                                    : const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                child: ListTile(
                                  onTap: () => showInputDialog(meeting),
                                  title: Text('زمان شروع : ${meeting['start_meet']}', style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal)),
                                  subtitle: Text(
                                    'زمان پایان : ${meeting['end_meet']}',
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () => showInputDialog(meeting),
                                    icon: const Icon(Icons.remove_red_eye, color: Colors.orange),
                                  ),
                                ),
                              );
                            },
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
