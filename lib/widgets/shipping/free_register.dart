import 'package:flutter/material.dart';

class FreeRegister extends StatelessWidget {
  const FreeRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green[400],
        child: const Image(
          width: 24,
          height: 24,
          color: Colors.white,
          image: AssetImage('assets/images/icons/free.png'),
        ),
      ),
      onTap: () {},
      title: const Text(
        'رایگان',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
