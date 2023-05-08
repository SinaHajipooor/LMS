import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  final double size;
  const Spinner({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitThreeInOut(
          color: Colors.blue,
          size: size,
          duration: const Duration(seconds: 3),
        ),
      ),
    );
  }
}
