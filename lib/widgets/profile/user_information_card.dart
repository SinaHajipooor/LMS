import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

// ignore: must_be_immutable
class UserInformationCard extends StatefulWidget {
  int selectedIndex;
  Function(int) onSelect; // final int selectedIndex

  UserInformationCard({super.key, required this.selectedIndex, required this.onSelect});
  @override
  State<UserInformationCard> createState() => _UserInformationCardState();
}

class _UserInformationCardState extends State<UserInformationCard> {
  //---------------- state -------------------
  File? _imageFile;

  //---------------- methods -------------------
  Future<void> _selectImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  //---------------- UI -------------------
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(22, 0, 22, 64),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.blue.withOpacity(0.1)),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(borderRadius: BorderRadius.circular(12), child: _imageFile != null ? Image.file(_imageFile!, width: 80, height: 80, fit: BoxFit.cover) : Image.network('http://45.149.77.156:8080/portal-assets/img/team/team-1.jpg', width: 80, height: 80, fit: BoxFit.cover)),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: GestureDetector(
                              onTap: _selectImage,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
                                child: const Icon(Icons.add, size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('سیناحاجی‌پور', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text('فراگیر', style: TextStyle(fontSize: 11, color: Colors.blue)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
                  child: Text('درباره من', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(32, 4, 32, 32),
                  child: Text('لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است', style: TextStyle(fontSize: 11)),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 32,
          left: 96,
          right: 96,
          child: Container(
            height: 32,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.8)),
            ]),
          ),
        ),
        Positioned(
          bottom: 34,
          left: 64,
          right: 64,
          child: Container(
            height: 68,
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onSelect(1);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.linear,
                      decoration: BoxDecoration(
                        color: widget.selectedIndex == 1 ? const Color.fromARGB(255, 43, 99, 241) : Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('اطلاعات\n شناسنامه‌ای', style: TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center)],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onSelect(2);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.linear,
                      decoration: BoxDecoration(
                        color: widget.selectedIndex == 2 ? const Color.fromARGB(255, 43, 99, 241) : Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('اطلاعات \n شغلی', style: TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center)],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onSelect(3);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.linear,
                      decoration: BoxDecoration(
                        color: widget.selectedIndex == 3 ? const Color.fromARGB(255, 43, 99, 241) : Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('اطلاعات \n تحصیلی', style: TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
