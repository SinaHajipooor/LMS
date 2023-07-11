import 'package:flutter/material.dart';
import '../spinner.dart';

class NewsList extends StatefulWidget {
  //----------------- fields -------------------
  final List<dynamic> newsList;
  const NewsList({super.key, required this.newsList});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //----------------- UI -------------------
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        if (_animation.value == 0) {
          return const Spinner(size: 25);
        } else {
          return Column(
            children: [
              Visibility(
                visible: widget.newsList.isNotEmpty,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(child: _buildNewsItem(widget.newsList[0])),
                          const SizedBox(width: 5),
                          Expanded(child: _buildNewsItem(widget.newsList[1])),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(child: _buildNewsItem(widget.newsList[2])),
                          const SizedBox(width: 5),
                          Expanded(child: _buildNewsItem(widget.newsList[3])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.newsList.isEmpty,
                child: SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'اخباری وجود ندارد ! ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget _buildNewsItem(dynamic newsItem) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 2 / 1.25,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: newsItem['main_image'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 7,
              right: 7,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  newsItem['name'],
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
