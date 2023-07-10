import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({Key? key}) : super(key: key);

  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12, top: 18),
              child: Text(
                'نظر خود را وارد کنید',
                style: theme.textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: RatingBarIndicator(
                rating: 2.5,
                itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                itemSize: 20,
              ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              style: theme.textTheme.bodyMedium,
              controller: _textController,
              onChanged: (values) {
                print(values);
              },
              maxLines: 3,
              decoration: const InputDecoration.collapsed(
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
              onPressed: () {
                // Use the value from _textController here
              },
              child: Text(
                'ثبت نظر',
                style: theme.textTheme.titleSmall!.apply(color: Colors.blue),
              ),
            )
          ],
        )
      ],
    );
  }
}
