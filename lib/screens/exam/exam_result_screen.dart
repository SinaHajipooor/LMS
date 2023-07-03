import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/circular_chart.dart';

class NewExamResultScreen extends StatefulWidget {
  const NewExamResultScreen({super.key});

  @override
  _NewExamResultScreenState createState() => _NewExamResultScreenState();
}

class _NewExamResultScreenState extends State<NewExamResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('نتیجه آزمون', style: TextStyle(fontSize: 16, color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.28,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 3,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Your text goes here',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 55),
                          child: CircularChartWidget(
                            data: [
                              CircularData('پاسخ های غلط', 5, Colors.red),
                              CircularData('بدون پاسخ', 10, Colors.orange),
                              CircularData('پاسخ های صحیح', 25, Colors.green),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
