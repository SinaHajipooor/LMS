import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../spinner.dart';

class AnnoucementSlider extends StatefulWidget {
  // --------------- feilds -----------------------
  final List<dynamic> announcements;
  const AnnoucementSlider(this.announcements, {super.key});

  @override
  State<AnnoucementSlider> createState() => _AnnoucementSliderState();
}

class _AnnoucementSliderState extends State<AnnoucementSlider> {
  // --------------- state -----------------------
  final CarouselController _controller = CarouselController();

  // --------------- UI -----------------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: Text('اطلاعیه های اخیر', style: theme.textTheme.titleMedium),
            ),
            IconButton(
                onPressed: () {
                  _controller.nextPage();
                },
                icon: const Icon(Icons.arrow_forward_rounded)),
          ],
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: widget.announcements.isNotEmpty,
          child: CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              autoPlayInterval: const Duration(seconds: 5),
              height: 175,
              autoPlay: true,
              padEnds: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              viewportFraction: 0.45,
            ),
            items: widget.announcements.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  item["main_image"],
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return const Center(
                                      child: Spinner(size: 30),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Text(
                            item['edu']['name'],
                            style: theme.textTheme.bodyMedium,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Visibility(
          visible: widget.announcements.isEmpty,
          child: SizedBox(
            height: 150,
            child: Center(
              child: Text('اطلاعیه‌ای وجود ندارد !', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal)),
            ),
          ),
        )
      ],
    );
  }
}
