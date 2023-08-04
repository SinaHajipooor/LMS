import 'imports/app_imports.dart';

final List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => IdentityProvider()),
  ChangeNotifierProvider(create: (_) => JobProvider()),
  ChangeNotifierProvider(create: (_) => InternalPassedCoursesProvider()),
  ChangeNotifierProvider(create: (_) => ExternalPassedCoursesProvider()),
  ChangeNotifierProvider(create: (_) => ActivityHistoryProvider()),
  ChangeNotifierProvider(create: (_) => UniversityTeachingProvider()),
  ChangeNotifierProvider(create: (_) => NonUniversityTeachingProvider()),
  ChangeNotifierProvider(create: (_) => CompilationsProvider()),
  ChangeNotifierProvider(create: (_) => LandingProvider()),
  ChangeNotifierProvider(create: (_) => ElectronicCourseProvider()),
  ChangeNotifierProvider(create: (_) => SimpleCourseProvider()),
  ChangeNotifierProvider(create: (_) => TeachersPanelProvider()),
  ChangeNotifierProvider(create: (_) => MyThemeModel()),
];
