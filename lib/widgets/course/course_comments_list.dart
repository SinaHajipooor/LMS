import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CourseCommentsList extends StatelessWidget {
  const CourseCommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('نظرات فراگیران', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          // const Divider(),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'http://45.149.77.156:8080/portal-assets/img/team/team-1.jpg',
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('سینا‌حاجی‌پور', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
                              Text('11 بهمن', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          const Text(
                            'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است',
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 12, top: 18),
                child: Text('نظر خود را وارد کنید', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              RatingBarIndicator(
                rating: 2.5,
                itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                itemSize: 20,
              ),
            ],
          ),
          Container(
            height: 130,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                maxLines: 3,
                decoration: InputDecoration.collapsed(
                  hintText: 'لطفا متن نظر خود را اینجا وارد کنید',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('ثبت نظر', style: TextStyle(fontSize: 14)),
              )
            ],
          )
        ],
      ),
    );
  }
}
