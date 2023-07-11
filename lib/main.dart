import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/providers/Course/SimpleCourseProvider.dart';
import 'package:lms/providers/Teachers/TeachersPanelProvider.dart';
import 'package:lms/screens/auth/auth_screen.dart';
import 'package:lms/screens/course/course_shipping_screen.dart';
import 'package:lms/screens/course/simple_course_detail_screen.dart';
import 'package:lms/screens/exam/exam_result_screen.dart';
import 'package:lms/screens/profile/activities_info_screen.dart';
import 'package:lms/screens/profile/external_passed_courses_screen.dart';
import 'package:lms/screens/profile/internal_passed_courses_screen.dart';
import 'package:lms/screens/profile/non_university_teaching_history_screen.dart';
import 'package:lms/screens/profile/university_taeching_history_screen.dart';
import 'package:lms/screens/profile/user_birth_certificate_form.dart';
import 'package:lms/screens/profile/user_education_screen.dart';
import 'package:lms/screens/profile/user_job_info_screen.dart';
import 'package:lms/screens/profile/user_profile_screen.dart';
import 'package:lms/screens/root/splash_screen.dart';
import 'package:lms/screens/teachers/presence_screen.dart';
import 'package:provider/provider.dart';

import 'providers/Landing/LandingProvider.dart';
import 'providers/Course/ElectronicCourseProvider.dart';
import 'screens/root/landing_screen.dart';
import 'screens/students/students_dashbord_screen.dart';
import 'screens/root/home_screen.dart';
import './providers/Auth/AuthProvider.dart';
import './screens/exam/exam_screen.dart';
import './screens/course/course_assessment_screen.dart';
import './screens/course/electronic_course_detail_screen.dart';
import './screens/course/simple_courses_screen.dart';

void main() async {
  // ignore: unused_local_variable
  final config = await initializeDateFormatting('fa_IR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper _themeHelper = ThemeHelper();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LandingProvider()),
        ChangeNotifierProvider(create: (_) => ElectronicCourseProvider()),
        ChangeNotifierProvider(create: (_) => SimpleCourseProvider()),
        ChangeNotifierProvider(create: (_) => TeachersPanelProvider()),
        ChangeNotifierProvider(create: (_) => MyThemeModel()),
      ],
      child: Consumer<MyThemeModel>(
        builder: (ctx, myThemeModel, _) {
          return MaterialApp(
            locale: const Locale('fa', 'IR'),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('fa'),
              Locale('en', 'US'),
            ],
            title: 'LMS',
            debugShowCheckedModeBanner: false,
            themeMode: myThemeModel.themeMode,
            theme: _themeHelper.getLightTheme(),
            darkTheme: _themeHelper.getDarkTheme(),
            home: const Directionality(
              textDirection: TextDirection.rtl,
              child: SplashScreen(),
            ),
            routes: {
              SplashScreen.routeName: (ctx) => const SplashScreen(),
              LandingScreen.routeName: (ctx) => const LandingScreen(),
              HomeScreen.routeName: (ctx) => const HomeScreen(),
              StudentsDashbordScreen.routeName: (ctx) => StudentsDashbordScreen(),
              ExamScreen.routeName: (ctx) => const ExamScreen(),
              ExamResultScreen.routeName: (ctx) => const ExamResultScreen(),
              ElectronicCourseDetailScreen.routeName: (ctx) => const ElectronicCourseDetailScreen(),
              CourseAssessmentScreen.routeName: (ctx) => const CourseAssessmentScreen(),
              SimpleCoursesScreen.routeName: (ctx) => const SimpleCoursesScreen(),
              SimpleCourseDetailScreen.routeName: (ctx) => const SimpleCourseDetailScreen(),
              UserProfileScreen.routeName: (ctx) => const UserProfileScreen(),
              PresenceScreen.routeName: (ctx) => const PresenceScreen(),
              CourseShippingScreen.routeName: (ctx) => const CourseShippingScreen(),
              UserBirthCertificateScreen.routeName: (ctx) => const UserBirthCertificateScreen(),
              UserEducationScreen.routeName: (ctx) => const UserEducationScreen(),
              UserJobInfoScreen.routeName: (ctx) => const UserJobInfoScreen(),
              ActivitiesInfoScreen.routeName: (ctx) => const ActivitiesInfoScreen(),
              InternalPassedCoursesScreen.routeName: (ctx) => const InternalPassedCoursesScreen(),
              ExternalPassedCoursesScreen.routeName: (ctx) => const ExternalPassedCoursesScreen(),
              UniversityTeachingHistoryScreen.routeName: (ctx) => const UniversityTeachingHistoryScreen(),
              NonUniversityTeachingHistoryScreen.routeName: (ctx) => const NonUniversityTeachingHistoryScreen(),
              AuthScreen.routeName: (ctx) => const AuthScreen(),
            },
          );
        },
      ),
    );
  }
}
