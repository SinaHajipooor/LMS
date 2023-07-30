import 'package:lms/app/app_localizations.dart';
import 'package:lms/app/app_providers.dart';
import 'package:lms/app/app_routes.dart';
import 'app/app_imports.dart';

void main() async {
  // ignore: unused_local_variable
  final config = await initializeDateFormatting('fa_IR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = ThemeHelper();

    return MultiProvider(
      providers: appProviders,
      child: Consumer<MyThemeModel>(
        builder: (ctx, myThemeModel, _) {
          return Builder(builder: (context) {
            return MaterialApp(
              locale: const Locale('fa', 'IR'),
              localizationsDelegates: appLocalizations,
              supportedLocales: appSupportedLocales,
              title: 'LMS',
              debugShowCheckedModeBanner: false,
              themeMode: myThemeModel.themeMode,
              theme: themeHelper.getLightTheme(),
              darkTheme: themeHelper.getDarkTheme(),
              home: const Directionality(
                textDirection: TextDirection.rtl,
                child: SplashScreen(),
              ),
              routes: appRoutes,
            );
          });
        },
      ),
    );
  }
}
