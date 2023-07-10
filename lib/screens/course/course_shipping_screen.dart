import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/helpers/InternetConnectivityHelper.dart';
import 'package:lms/providers/Course/ElectronicCourseProvider.dart';
import 'package:lms/widgets/course/shipping/course_payment_approachs.dart';
import 'package:lms/widgets/course/shipping/course_purchase_details.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    fetchCourseShippingDetails(id);
    super.didChangeDependencies();
  }

  // ------------------- methods -------------------
  Future<void> fetchCourseShippingDetails(int courseId) async {
    await Provider.of<ElectronicCourseProvider>(context, listen: false).fetchCourseShippingDetails(courseId);
    setState(() {
      courseInfo = Provider.of<ElectronicCourseProvider>(context, listen: false).courseShippingDetails;
      _isLoading = false;
    });
  }

  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  // ------------------- UI -------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('خرید دوره', style: theme.textTheme.titleLarge),
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
                    CoursePaymentApproachs(paymentGateways: Provider.of<ElectronicCourseProvider>(context).coursePaymentGateways),
                  ],
                ),
              ),
      ),
    );
  }
}
