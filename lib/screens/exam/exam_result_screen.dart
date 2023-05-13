import 'package:flutter/material.dart';
import '../../widgets/elements/circular_chart.dart';
import '../course/electronic_course_detail_screen.dart';

class ExamResultScreen extends StatefulWidget {
  static const routeName = '/exam-result-screen';
  const ExamResultScreen({Key? key}) : super(key: key);

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
  //------------------- state -----------------------
  int? courseId;
  //------------------- method -----------------------

  //------------------- lifecycle -----------------------
  @override
  void didChangeDependencies() {
    setState(() {
      courseId = ModalRoute.of(context)!.settings.arguments as int;
    });
    super.didChangeDependencies();
  }

  //------------------- UI -----------------------

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(ElectronicCourseDetailScreen.routeName, arguments: courseId);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('نتیجه آزمون', style: TextStyle(color: Colors.black, fontSize: 16)),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: deviceSize.width / 3,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('پاسخ های صحیح', style: TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold)),
                            Text('25', style: TextStyle(fontSize: 17, color: Colors.green[300])),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: deviceSize.width / 3,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('پاسخ های غلط', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.red)),
                            Text(
                              '5',
                              style: TextStyle(fontSize: 17, color: Colors.red[300]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: deviceSize.width / 3,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'پاسخ داده نشده',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.orange),
                            ),
                            Text('10', style: TextStyle(fontSize: 17, color: Colors.orange[300])),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  elevation: 1,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CircularChartWidget(
                        data: [
                          CircularData('پاسخ های غلط', 5, Colors.red),
                          CircularData('بدون پاسخ', 10, Colors.orange),
                          CircularData('پاسخ های صحیح', 25, Colors.green),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
                                ),
                                const SizedBox(width: 2),
                                const Text(
                                  'پاسخ های صحیح',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                                ),
                                const SizedBox(width: 2),
                                const Text('پاسخ های غلط', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(5)),
                                ),
                                const SizedBox(width: 2),
                                const Text('بدون پاسخ', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: double.infinity,
                child: Card(
                  elevation: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: const [
                            Text('نمره آزمون : '),
                            Text('25', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: const [
                            Text('وضعیت قبولی : '),
                            Text('قبول', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pushReplacementNamed(ElectronicCourseDetailScreen.routeName, arguments: courseId),
                      child: const Text(
                        'بازگشت به دوره',
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
