import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey,
                      child: Image.asset('assets/images/avatar.png', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('سیناحاجی‌پور', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text('فراگیر', style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: InkWell(
                child: Image.asset('assets/images/icons/edit.png', width: 20, height: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
