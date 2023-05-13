import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String imagePath;

  ImagePreview({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              title: const Text('تصویر', style: TextStyle(fontSize: 17, color: Colors.black)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
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
