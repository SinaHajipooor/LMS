import 'package:flutter/material.dart';
import 'package:lms/helpers/InternetConnectivityHelper.dart';
import 'package:lms/screens/course/electronic_course_detail_screen.dart';
import 'package:lms/widgets/elements/circular_chart.dart';

class ExamResultScreen extends StatefulWidget {
  static const routeName = '/exam-result-screen';
  const ExamResultScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExamResultScreenState createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
  //------------------- state -----------------------
  int? courseId;

  //------------------- lifecycle -----------------------

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      courseId = ModalRoute.of(context)!.settings.arguments as int;
    });
    super.didChangeDependencies();
  }

  // --------------- methods -----------------
  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  //------------------- UI -----------------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => Navigator.of(context).pushReplacementNamed(ElectronicCourseDetailScreen.routeName, arguments: courseId),
        child: Container(
          width: 100,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.blue.withOpacity(0.5)),
            ],
          ),
          child: const Center(child: Text('بازگشت به دوره', style: TextStyle(color: Colors.white, fontSize: 13))),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('نتیجه آزمون', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 120,
                    width: deviceSize.width / 3.25,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 1,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('assets/images/icons/checked.png', width: 35, height: 35),
                            const Text('25', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    width: deviceSize.width / 3.25,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 1,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('assets/images/icons/eye.png', width: 35, height: 35),
                            const Text('10', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    width: deviceSize.width / 3.25,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 1,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('assets/images/icons/close.png', width: 35, height: 35),
                            const Text('5', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 15),
              child: SizedBox(
                height: 220,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0, left: 10),
                          child: CircularChartWidget(
                            data: [
                              CircularData('پاسخ های غلط', 5, Colors.red),
                              CircularData('بدون پاسخ', 10, Colors.orange),
                              CircularData('پاسخ های صحیح', 25, Colors.green),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
                                ),
                                const SizedBox(width: 3),
                                const Text(
                                  'پاسخ های صحیح',
                                  style: TextStyle(fontSize: 11),
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
                                const SizedBox(width: 3),
                                const Text('پاسخ های غلط', style: TextStyle(fontSize: 11)),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(5)),
                                ),
                                const SizedBox(width: 3),
                                const Text('بدون پاسخ', style: TextStyle(fontSize: 11)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
              width: deviceSize.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 1,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Text('نمره آزمون : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 5),
                        Text('25  از 100', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
              width: deviceSize.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        const Text('وضعیت قبولی : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 5),
                        Row(
                          children: [
                            const Text(
                              'قبول',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 5),
                            Image.asset('assets/images/icons/checked.png', width: 19, height: 19)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
