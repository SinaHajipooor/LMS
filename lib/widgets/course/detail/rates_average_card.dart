import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatesAverageCard extends StatelessWidget {
  const RatesAverageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 8),
            child: Text('میانگین امتیازات', style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(height: 5),
          Center(
            child: RatingBarIndicator(
              rating: 3.5,
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              itemSize: 34,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
