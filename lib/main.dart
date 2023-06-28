import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lms/providers/Course/SimpleCourseProvider.dart';
import 'package:lms/providers/Teachers/TeachersPanelProvider.dart';
import 'package:lms/screens/profile/profile_screen.dart';
import 'package:lms/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/Landing/LandingProvider.dart';
import './providers/Course/CourseProvider.dart';
import './screens/landing_screen.dart';
import './screens/login_screen.dart';
import './screens/authenticate_screen.dart';
import './screens/dashbord_screen.dart';
import './screens/home_screen.dart';
import './providers/Auth/AuthProvider.dart';
import './screens/shopping_basket_screen.dart';
import './screens/exam/exam_screen.dart';
import './screens/course/course_assessment_screen.dart';
import './screens/exam/exam_result_screen.dart';
import './screens/course/electronic_course_detail_screen.dart';
import './screens/course/simple_courses_screen.dart';

void main() async {
  // ignore: unused_local_variable
  final config = await initializeDateFormatting('fa_IR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => LandingProvider()),
        ChangeNotifierProvider(create: (ctx) => CourseProvider()),
        ChangeNotifierProvider(create: (ctx) => SimpleCourseProvider()),
        ChangeNotifierProvider(create: (ctx) => TeachersPanelProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
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
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'YekanBakh', scaffoldBackgroundColor: Colors.white),
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: SplashScreen(),
          ),
          routes: {
            SplashScreen.routeName: (ctx) => const SplashScreen(),
            LandingScreen.routeName: (ctx) => const LandingScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            AuthenticateScreen.routeName: (ctx) => const AuthenticateScreen(),
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            DashbordScreen.routeName: (ctx) => DashbordScreen(),
            ShoppingBasketScreen.routeName: (ctx) => const ShoppingBasketScreen(),
            ExamScreen.routeName: (ctx) => const ExamScreen(),
            ExamResultScreen.routeName: (ctx) => const ExamResultScreen(),
            ElectronicCourseDetailScreen.routeName: (ctx) => const ElectronicCourseDetailScreen(),
            CourseAssessmentScreen.routeName: (ctx) => const CourseAssessmentScreen(),
            SimpleCoursesScreen.routeName: (ctx) => const SimpleCoursesScreen(),
            ProfileScreen.routeName: (ctx) => const ProfileScreen(),
          },
        ),
      ),
    );
  }
}
