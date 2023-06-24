import 'package:flutter/material.dart';

class DashbordInfoCards extends StatelessWidget {
  const DashbordInfoCards({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCard(context, 'مدیر', '2', Colors.green),
              _buildCard(context, 'رابط آموزشی', '23', Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCard(context, 'مدرس', '7', Colors.red),
              _buildCard(context, 'فراگیر', '10', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildCard(BuildContext context, String title, String count, Color color) {
  final deviceSize = MediaQuery.of(context).size;
  return SizedBox(
    height: 80,
    width: deviceSize.width / 2.2,
    child: Card(
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title, style: const TextStyle(fontSize: 13)),
              Text(count, style: TextStyle(color: color)),
            ],
          ),
        ),
      ),
    ),
  );
}
