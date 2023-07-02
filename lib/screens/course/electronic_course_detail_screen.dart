import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/widgets/course/course_feedback.dart';
import 'package:lms/widgets/course/course_price_card.dart';
import '../../widgets/course/course_teachers_list.dart';
import '../../widgets/course/course_image.dart';
import '../../widgets/course/course_detail_text.dart';
import '../../widgets/course/course_name.dart';
import 'package:provider/provider.dart';
import '../../providers/Course/CourseProvider.dart';
import '../shopping_basket_screen.dart';
import '../home_screen.dart';
import '../../widgets/elements/spinner.dart';
import '../../widgets/course/course_exams_list.dart';
import '../../widgets/course/course_description.dart';
import '../../widgets/course/course_detail_cards.dart';
import '../../widgets/course/course_comments_list.dart';
import '../../widgets/course/course_resources_card.dart';
import '../../widgets/course/course_assessment.dart';
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
    await Provider.of<CourseProvider>(context, listen: false).fetchCourseDetails(courseId);
    setState(() {
      courseDetails = Provider.of<CourseProvider>(context, listen: false).courseDetails;
      _isLoading = false;
    });
  }

  Future<void> submitCourse() async {
    Navigator.of(context).pushNamed(ShoppingBasketScreen.routeName, arguments: courseDetails?['id']);
  }
  //---------------- UI ------------------

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        return false;
      },
      child: Scaffold(
        floatingActionButton: AnimatedOpacity(
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
                      const CustomAppbar(
                        title: 'اطلاعات دوره',
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            Consumer<CourseProvider>(builder: (context, myProvider, child) {
                              return CourseName(courseName: myProvider.courseDetails['title']);
                            }),
                            const SizedBox(height: 25),
                            const CourseTeachersList(),
                            const SizedBox(height: 35),
                            Consumer<CourseProvider>(builder: (context, myProvider, child) {
                              return CourseImage(
                                imageUrl: myProvider.courseDetails['main_image'],
                                lessonName: myProvider.courseDetails['lesson_id'],
                              );
                            }),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(32, 20, 32, 16),
                              child: Text(
                                'توضیحات دوره',
                                style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Consumer<CourseProvider>(builder: (context, myProvider, child) {
                              return CourseDetailText(description: myProvider.courseDetails['description']);
                            }),
                            Consumer<CourseProvider>(builder: (context, myProvider, child) {
                              return CourseDetailCards(
                                seasonsCount: myProvider.courseDetails['seasons_count'],
                                sessionCount: myProvider.courseDetails['sessions_count'],
                                time: myProvider.courseDetails['time'],
                                studentsCount: myProvider.courseDetails['students_count'],
                              );
                            }),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: deviceSize.width,
                              child: Row(
                                children: [
                                  Consumer<CourseProvider>(builder: (context, myProvider, child) {
                                    return CourseResourcesCard(seasons: myProvider.courseDetails['seasons'], courseId: myProvider.courseDetails['id']);
                                  }),
                                  Consumer<CourseProvider>(builder: (context, myProvider, child) {
                                    return CourseAssessment(courseId: myProvider.courseDetails['id']);
                                  }),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Consumer<CourseProvider>(builder: (context, myProvider, child) {
                              return CourseExamsList(title: 'آزمون‌ها', exams: myProvider.courseDetails['exams'], courseId: myProvider.courseDetails['id']);
                            }),
                            const SizedBox(height: 20),
                            Consumer<CourseProvider>(builder: (context, myProvider, child) {
                              return CourseDescription(title: 'گواهینامه', description: myProvider.courseDetails['description']);
                            }),
                            const SizedBox(height: 15),
                            Consumer<CourseProvider>(builder: (context, myProvider, child) {
                              return CoursePriceCard(amount: myProvider.courseDetails['amount'], discount: myProvider.courseDetails['discount'], finalAmount: myProvider.courseDetails['final_amount']);
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
                            colors: [Colors.white, Colors.white.withOpacity(0)],
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
