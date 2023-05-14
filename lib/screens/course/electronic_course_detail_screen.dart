import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  bool _isLoading = false;
  Map<String, dynamic>? courseDetails;
  final _scrollController = ScrollController();
  bool _isFabVisible = true;
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

  // ---------------  methods ---------------
  Future<void> fetchElectronicCourseDetails(int courseId) async {
    setState(() {
      _isLoading = true;
    });
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
      child: _isLoading
          ? const Center(child: Spinner(size: 40))
          : Scaffold(
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
              body: Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      const CustomAppbar(
                        title: 'اطلاعات دوره',
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            CourseName(
                              courseName: courseDetails?['title'],
                            ),
                            const SizedBox(height: 25),
                            const CourseTeachersList(),
                            const SizedBox(height: 35),
                            CourseImage(
                              imageUrl: courseDetails?['main_image'],
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(32, 20, 32, 16),
                              child: Text(
                                'توضیحات دوره',
                                style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                            CourseDetailText(description: courseDetails?['description']),
                            CourseDetailCards(seasonsCount: courseDetails?['seasons_count'], sessionCount: courseDetails?['sessions_count'], time: courseDetails?['time'], studentsCount: courseDetails?['students_count'], lessonName: courseDetails?['lesson_id']),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: deviceSize.width,
                              child: Row(
                                children: [
                                  CourseResourcesCard(seasons: courseDetails?['seasons'], courseId: courseDetails?['id']),
                                  CourseAssessment(courseId: courseDetails?['id']),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            CourseExamsList(title: 'آزمون‌ها', exams: courseDetails?['exams'], courseId: courseDetails?['id']),
                            const SizedBox(height: 20),
                            CourseDescription(title: 'گواهینامه', description: courseDetails?['description']),
                            const SizedBox(height: 15),
                            CoursePriceCard(amount: courseDetails?['amount'], discount: courseDetails?['discount'], finalAmount: courseDetails?['final_amount']),
                            const SizedBox(height: 20),
                            const CourseCommentsList(),
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
