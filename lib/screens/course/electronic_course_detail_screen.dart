import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/helpers/InternetConnectivityHelper.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/screens/course/course_shipping_screen.dart';
import 'package:lms/widgets/course/detail/course_feedback.dart';
import 'package:lms/widgets/course/detail/course_price_card.dart';
import '../../widgets/course/detail/course_teachers_list.dart';
import '../../widgets/course/detail/course_image.dart';
import '../../widgets/course/detail/course_detail_text.dart';
import '../../widgets/course/detail/course_name.dart';
import 'package:provider/provider.dart';
import '../../providers/Course/ElectronicCourseProvider.dart';
import '../root/home_screen.dart';
import '../../widgets/elements/spinner.dart';
import '../../widgets/course/detail/course_exams_list.dart';
import '../../widgets/course/detail/course_description.dart';
import '../../widgets/course/detail/course_detail_cards.dart';
import '../../widgets/course/detail/course_comments_list.dart';
import '../../widgets/course/recourses/course_resources_card.dart';
import '../../widgets/course/assessment/course_assessment.dart';
import '../../widgets/elements/custom_appbar.dart';

class ElectronicCourseDetailScreen extends StatefulWidget {
  static const routeName = '/electronic-course-detail-screen';

  const ElectronicCourseDetailScreen({super.key});

  @override
  State<ElectronicCourseDetailScreen> createState() => _ElectronicCourseDetailScreenState();
}

class _ElectronicCourseDetailScreenState extends State<ElectronicCourseDetailScreen> {
  // ---------------  state  --------------
  bool _isLoading = true;
  Map<String, dynamic>? courseDetails;
  final _scrollController = ScrollController();
  bool _isFabVisible = true;
  TextEditingController inputControllers = TextEditingController();
  // ---------------  lifecycle  ---------------

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _isFabVisible = false;
        });
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _isFabVisible = true;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    int courseId = ModalRoute.of(context)!.settings.arguments as int;
    fetchElectronicCourseDetails(courseId);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    inputControllers.dispose();
    super.dispose();
  }

  // ---------------  methods ---------------
  Future<void> fetchElectronicCourseDetails(int courseId) async {
    await Provider.of<ElectronicCourseProvider>(context, listen: false).fetchCourseDetails(courseId);
    setState(() {
      courseDetails = Provider.of<ElectronicCourseProvider>(context, listen: false).courseDetails;
      _isLoading = false;
    });
  }

  Future<void> submitCourse() async {
    Navigator.of(context).pushNamed(CourseShippingScreen.routeName, arguments: courseDetails?['id']);
  }

  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  //---------------- UI ------------------

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    final lightShadowColors = [Colors.white, Colors.white.withOpacity(0)];
    final darkShadowColors = [theme.scaffoldBackgroundColor, theme.scaffoldBackgroundColor.withOpacity(0)];
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        return false;
      },
      child: Scaffold(
        floatingActionButton: _isLoading
            ? null
            : AnimatedOpacity(
                opacity: _isFabVisible ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: InkWell(
                  onTap: () => submitCourse(),
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
                    child: const Center(child: Text('ثبت‌نام در دوره', style: TextStyle(color: Colors.white, fontSize: 13))),
                  ),
                ),
              ),
        body: _isLoading
            ? const Center(child: Spinner(size: 35))
            : Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    slivers: [
                      const CustomAppbar(title: 'اطلاعات دوره'),
                      SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            Consumer<ElectronicCourseProvider>(builder: (context, myProvider, child) {
                              return CourseName(courseName: myProvider.courseDetails['title'] ?? '');
                            }),
                            const SizedBox(height: 25),
                            const CourseTeachersList(),
                            const SizedBox(height: 35),
                            Consumer<ElectronicCourseProvider>(builder: (context, myProvider, child) {
                              return CourseImage(
                                imageUrl: myProvider.courseDetails['main_image'],
                                lessonName: myProvider.courseDetails['lesson_id'] ?? '_',
                              );
                            }),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 20, 32, 16),
                              child: Text(
                                'توضیحات دوره',
                                style: theme.textTheme.titleLarge!.apply(color: Colors.blue),
                              ),
                            ),
                            Consumer<ElectronicCourseProvider>(builder: (context, myProvider, child) {
                              return CourseDetailText(description: myProvider.courseDetails['description'] ?? '');
                            }),
                            Consumer<ElectronicCourseProvider>(builder: (context, myProvider, child) {
                              return CourseDetailCards(
                                seasonsCount: myProvider.courseDetails['seasons_count'] ?? 0,
                                sessionCount: myProvider.courseDetails['sessions_count'] ?? 0,
                                time: myProvider.courseDetails['time'] ?? '0',
                                studentsCount: myProvider.courseDetails['students_count'] ?? 0,
                              );
                            }),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: deviceSize.width,
                              child: Row(
                                children: [
                                  Consumer<ElectronicCourseProvider>(builder: (context, myProvider, child) {
                                    return CourseResourcesCard(
                                      seasons: myProvider.courseDetails['seasons'] ?? [],
                                      courseId: myProvider.courseDetails['id'] ?? 0,
                                      imageUrl: myProvider.courseDetails['main_image'],
                                      courseName: myProvider.courseDetails['title'] ?? '_',
                                      coursePeriod: myProvider.courseDetails['time'] ?? '_',
                                      studentsCount: myProvider.courseDetails['students_count'] ?? 0,
                                    );
                                  }),
                                  Consumer<ElectronicCourseProvider>(builder: (context, myProvider, child) {
                                    return CourseAssessment(courseId: myProvider.courseDetails['id'] ?? 0);
                                  }),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Consumer<ElectronicCourseProvider>(builder: (context, myProvider, child) {
                              return CourseExamsList(title: 'آزمون‌ها', exams: myProvider.courseDetails['exams'] ?? [], courseId: myProvider.courseDetails['id'] ?? 0);
                            }),
                            const SizedBox(height: 20),
                            Consumer<ElectronicCourseProvider>(builder: (context, myProvider, child) {
                              return CourseDescription(title: 'گواهینامه', description: myProvider.courseDetails['description'] ?? '');
                            }),
                            const SizedBox(height: 15),
                            Consumer<ElectronicCourseProvider>(builder: (context, myProvider, child) {
                              return CoursePriceCard(amount: myProvider.courseDetails['amount'] ?? '_', discount: myProvider.courseDetails['discount'] ?? '_', finalAmount: myProvider.courseDetails['final_amount'] ?? '_');
                            }),
                            const SizedBox(height: 20),
                            const CourseCommentsList(),
                            const FeedbackWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _isFabVisible,
                    child: Positioned(
                      bottom: 0,
                      child: Container(
                        width: deviceSize.width,
                        height: 116,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: themeMode == ThemeMode.light ? lightShadowColors : darkShadowColors,
                          ),
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
