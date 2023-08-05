import 'package:flutter/material.dart';
import 'package:lms/helpers/Theme/theme_helper.dart';
import 'package:provider/provider.dart';

class CourseDescription extends StatefulWidget {
// --------------- feilds ----------------
  final String title;
  final String description;
  const CourseDescription({super.key, required this.title, required this.description});

  @override
  State<CourseDescription> createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<CourseDescription> {
// --------------- state ----------------

  bool _isExpanded = false;

// --------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    return InkWell(
      onTap: () {
        setState(() {
          widget.description.isNotEmpty ? _isExpanded = !_isExpanded : null;
        });
      },
      child: Card(
        elevation: 0.5,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 680),
          curve: Curves.easeInOut,
          height: _isExpanded ? 190 : 55,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.description.isNotEmpty ? _isExpanded = !_isExpanded : null;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.description.isNotEmpty ? widget.title : 'برای این درس گواهینامه وجود ندارد ! ',
                            style: TextStyle(
                              color: _isExpanded ? Colors.blue : (themeMode == ThemeMode.dark ? Colors.white : Colors.black),
                              fontSize: _isExpanded ? 16.0 : (widget.description.isNotEmpty ? 15 : 14),
                              fontWeight: _isExpanded ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          Icon(_isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_left, size: 25.0),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Visibility(
                        visible: widget.description.isNotEmpty,
                        child: Expanded(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: _isExpanded ? 1.0 : 0.0,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.description,
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                            ),
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
