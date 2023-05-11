import 'package:flutter/material.dart';
import '../spinner.dart';

class NewsList extends StatelessWidget {
  //----------------- fields -------------------
  final List<dynamic> newsList;
  NewsList({required this.newsList});
  //----------------- UI -------------------
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.delayed(const Duration(seconds: 2), () => newsList),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Spinner(size: 25);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildNewsItem(snapshot.data![0])),
                  Expanded(child: _buildNewsItem(snapshot.data![1])),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _buildNewsItem(snapshot.data![2])),
                  Expanded(child: _buildNewsItem(snapshot.data![3])),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildNewsItem(dynamic newsItem) {
    return Container(
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
              child: Image.network(
                newsItem['main_image'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                newsItem['name'],
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
