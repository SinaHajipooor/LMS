import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lms/widgets/elements/slider/tms_item.dart';
// import '../spinner.dart';

class TmsSlider extends StatefulWidget {
  // feilds
  final List<dynamic> tmsList;
  const TmsSlider(this.tmsList, {super.key});

  @override
  State<TmsSlider> createState() => _TmsSliderState();
}

class _TmsSliderState extends State<TmsSlider> {
  //---------------- state ------------------
  final CarouselController _controller = CarouselController();
  //---------------- UI ------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: const Text('مراکز آموزشی', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            ),
            IconButton(
              onPressed: () {
                _controller.nextPage();
              },
              icon: const Icon(Icons.arrow_forward_rounded),
            ),
          ],
        ),
        const SizedBox(height: 30),
        CarouselSlider.builder(
          itemCount: widget.tmsList.length,
          options: CarouselOptions(
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.575,
            aspectRatio: 2,
            initialPage: 0,
            disableCenter: true,
            scrollPhysics: const BouncingScrollPhysics(),
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          itemBuilder: (context, index, realIndex) {
            return TmsItem(imageUrl: widget.tmsList[realIndex]['logo'], title: widget.tmsList[realIndex]['name']);
          },
        ),
      ],
    );
  }
}








//  CarouselSlider(
//           carouselController: _controller,
//           options: CarouselOptions(
//             height: 175,
//             autoPlay: false,
//             aspectRatio: 16 / 9,
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enableInfiniteScroll: true,
//             autoPlayAnimationDuration: const Duration(milliseconds: 600),
//             viewportFraction: 0.46,
//           ),
//           items: widget.tmsList.map((item) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Column(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.8,
//                         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         child: AspectRatio(
//                           aspectRatio: 16 / 9,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(12.0),
//                             child: Image.network(
//                               item["logo"],
//                               fit: BoxFit.cover,
//                               loadingBuilder: (context, child, progress) {
//                                 if (progress == null) return child;
//                                 return Center(
//                                   child: Spinner(size: 30),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     Container(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//                         child: Text(
//                           item['name'],
//                           style: const TextStyle(fontSize: 11.0, color: Colors.black),
//                           maxLines: 2,
//                           textAlign: TextAlign.center,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           }).toList(),
//         ),