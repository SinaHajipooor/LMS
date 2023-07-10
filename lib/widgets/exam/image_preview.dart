import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String imagePath;

  const ImagePreview({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              title: Text('تصویر', style: Theme.of(context).textTheme.titleMedium),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.iconTheme!.color),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Center(
              child: Image.network(imagePath),
            ),
          );
        }));
      },
      child: const Text(
        'تصویر',
        style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }
}
