import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/providers/Course/CourseProvider.dart';
import 'package:lms/widgets/course/course_payment_approachs.dart';
import 'package:lms/widgets/course/course_purchase_details.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:provider/provider.dart';

class CourseShippingScreen extends StatefulWidget {
  static const routeName = '/course-shipping-screen';
  const CourseShippingScreen({super.key});

  @override
  State<CourseShippingScreen> createState() => _CourseShippingScreenState();
}

class _CourseShippingScreenState extends State<CourseShippingScreen> {
  // ------------------- state -------------------

  Map<String, dynamic>? courseInfo;
  bool _isLoading = true;
  // ------------------- lifecycle ------------------
  @override
  void didChangeDependencies() {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    fetchCourseShippingDetails(id);
    super.didChangeDependencies();
  }

  // ------------------- methods -------------------
  Future<void> fetchCourseShippingDetails(int courseId) async {
    await Provider.of<CourseProvider>(context, listen: false).fetchCourseShippingDetails(courseId);
    setState(() {
      courseInfo = Provider.of<CourseProvider>(context, listen: false).courseShippingDetails;
      _isLoading = false;
    });
  }

  // ------------------- UI -------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('خرید دوره', style: TextStyle(color: Colors.black, fontSize: 15)),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_right, color: Colors.black, size: 22),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: Spinner(size: 32))
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CoursePurchaseDetails(
                      courseDiscount: courseInfo?['discount'],
                      courseImageUrl: courseInfo?['main_image'],
                      sessionsCount: courseInfo?['sessions_count'],
                      coursePeriod: courseInfo?['time'],
                      courseName: courseInfo?['title'],
                      courseTotalAmount: courseInfo?['final_amount'],
                    ),
                    CoursePaymentApproachs(),
                  ],
                ),
              ),
      ),
    );
  }
}
