import 'package:flutter/material.dart';

class CourseSeasonCard extends StatefulWidget {
  //-------------------- feilds -----------------------
  final List sessions;
  final String title;
  const CourseSeasonCard({super.key, required this.sessions, required this.title});

  @override
  State<CourseSeasonCard> createState() => _CourseSeasonCardState();
}

class _CourseSeasonCardState extends State<CourseSeasonCard> {
  //-------------------- state -----------------------
  bool _isExpanded = false;
  //-------------------- UI -----------------------

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Card(
        elevation: 0.5,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 680),
          curve: Curves.easeInOut,
          height: _isExpanded ? 400 : 55,
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
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(widget.title,
                                style: TextStyle(
                                  fontSize: _isExpanded ? 17 : 15,
                                  color: _isExpanded ? Colors.blue : Colors.black,
                                  fontWeight: _isExpanded ? FontWeight.bold : FontWeight.normal,
                                )),
                            Icon(_isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_left, size: 25.0),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: _isExpanded ? 1.0 : 0.0,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: widget.sessions.length,
                            itemBuilder: (ctx, i) => Container(
                              decoration: widget.sessions.length == i + 1
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
                                title: Text(widget.sessions[i]['title'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                subtitle: Text('مدت جلسه : ${widget.sessions[i]['duration']} دقیقه     -    ${widget.sessions[i]['is_free']}', style: const TextStyle(fontSize: 11)),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.play_arrow, color: Colors.green),
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
