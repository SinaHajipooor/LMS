import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../spinner.dart';

class TeachersListSlider extends StatelessWidget {
  // feilds
  final List<dynamic> teachersList;
  const TeachersListSlider(this.teachersList, {super.key});

  //UI
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 125,
        autoPlay: false,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        viewportFraction: 0.30,
      ),
      items: teachersList.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          'http://45.149.77.156:8080/portal-assets/img/team/team-1.jpg',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Center(
                              child: Spinner(size: 30),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Column(
                      children: const [
                        Text(
                          'سیناحاجی‌پور',
                          style: TextStyle(fontSize: 11.0, color: Colors.black),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'مدرس فلاتر',
                          style: TextStyle(fontSize: 9.0, color: Colors.grey),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
