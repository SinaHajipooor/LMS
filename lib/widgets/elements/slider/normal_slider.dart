import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NormalSlider extends StatelessWidget {
// feilds
  final List<dynamic> slideImages;
  const NormalSlider(this.slideImages, {super.key});

  //UI
  @override
  Widget build(BuildContext context) {
    if (slideImages.isEmpty) {
      return SizedBox(
        height: 160,
        child: Center(
          child: Text(
            'اسلایدی جهت نمایش وجود ندارد !',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
          ),
        ),
      );
    }
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.95,
          ),
          items: slideImages.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(item['main_image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
