import 'package:lms/app/AppProviders.dart';
import 'package:lms/app/AppRoutes.dart';
import 'app/AppImports.dart';

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
