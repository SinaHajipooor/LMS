import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/helpers/connections/internet_connectivity_helper.dart';
import 'package:lms/helpers/theme/theme_helper.dart';
import 'package:lms/providers/Course/SimpleCourseProvider.dart';
import 'package:lms/screens/course/course_shipping_screen.dart';
import 'package:lms/widgets/course/detail/course_comments_list.dart';
import 'package:lms/widgets/course/detail/course_detail_cards.dart';
import 'package:lms/widgets/course/detail/course_detail_text.dart';
import 'package:lms/widgets/course/detail/course_feedback.dart';
import 'package:lms/widgets/course/detail/course_image.dart';
import 'package:lms/widgets/course/detail/course_name.dart';
import 'package:lms/widgets/course/detail/course_teachers_list.dart';
import 'package:lms/widgets/course/simple/course_files_drawer.dart';
import 'package:lms/widgets/course/simple/simple_course_meetings.dart';
import 'package:lms/widgets/elements/custom_appbar.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:provider/provider.dart';

class SimpleCourseDetailScreen extends StatefulWidget {
  static const routeName = '/simple-course-detail-screen';
  const SimpleCourseDetailScreen({super.key});

  @override
  State<SimpleCourseDetailScreen> createState() => _SimpleCourseDetailScreenState();
}

class _SimpleCourseDetailScreenState extends State<SimpleCourseDetailScreen> {
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
    await Provider.of<SimpleCourseProvider>(context, listen: false).fetchSimpleCourseDetails(courseId);
    setState(() {
      courseDetails = Provider.of<SimpleCourseProvider>(context, listen: false).courseDetails;
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
        Navigator.of(context).pop();
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
                    child: const Center(
                      child: Text(
                        'ثبت‌نام در دوره',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
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
                            const SizedBox(height: 10),
                            Consumer<SimpleCourseProvider>(builder: (context, myProvider, child) {
                              return CourseName(courseName: myProvider.courseDetails['title'] ?? '');
                            }),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                const Expanded(child: CourseTeachersList()),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 30),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/icons/notification.png',
                                        width: 25,
                                        height: 22,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 10),
                                      Image.asset(
                                        'assets/images/icons/bookmark.png',
                                        width: 25,
                                        height: 22,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 35),
                            Consumer<SimpleCourseProvider>(
                              builder: (context, myProvider, child) {
                                return CourseImage(
                                  imageUrl: myProvider.courseDetails['main_image'],
                                  lessonName: myProvider.courseDetails['lesson_id'] ?? '_',
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(32, 15, 32, 16),
                              child: Text(
                                'توضیحات دوره',
                                style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Consumer<SimpleCourseProvider>(
                              builder: (context, myProvider, child) {
                                return CourseDetailText(description: myProvider.courseDetails['description'] ?? '');
                              },
                            ),
                            Consumer<SimpleCourseProvider>(builder: (context, myProvider, child) {
                              return CourseDetailCards(
                                seasonsCount: myProvider.courseDetails['seasons_count'] ?? 0,
                                sessionCount: myProvider.courseDetails['sessions_count'] ?? 0,
                                time: myProvider.courseDetails['time'] ?? '_',
                                studentsCount: myProvider.courseDetails['students_count'] ?? 0,
                              );
                            }),
                            const SizedBox(height: 15),
                            const CourseFilesDrawer(),
                            const SizedBox(height: 20),
                            Consumer<SimpleCourseProvider>(builder: (context, myprovider, child) {
                              return SimpleCourseMeetings(meetings: myprovider.courseDetails['meetings'] ?? []);
                            }),
                            const SizedBox(height: 15),
                            const CourseCommentsList(),
                            const FeedbackWidget(),
                          ],
                        ),
                      )
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
