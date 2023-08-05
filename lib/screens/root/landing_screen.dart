import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:lms/helpers/connections/internet_connectivity_helper.dart';
import 'package:lms/helpers/theme/theme_helper.dart';
import 'package:lms/screens/auth/auth_screen.dart';
import 'package:lms/widgets/landing/amazing_courses_list.dart';
import 'package:lms/widgets/landing/landing_appBar.dart';
import 'package:provider/provider.dart';
import '../../widgets/elements/slider/annoucement_slider.dart';
import '../../widgets/elements/slider/normal_slider.dart';
import '../../providers/Landing/LandingProvider.dart';
import '../../widgets/elements/slider/tms_slider.dart';
import '../../widgets/elements/slider/teachers_list.dart';
import '../../widgets/elements/slider/news_list.dart';
import '../../widgets/elements/spinner.dart';
import '../../providers/Auth/AuthProvider.dart';
import 'home_screen.dart';

class LandingScreen extends StatefulWidget {
// --------------- feilds -----------------
  static const routeName = '/landing-screen';

  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
// --------------- state -----------------
  bool _isLoading = false;
  final _scrollController = ScrollController();
  bool _isFabVisible = true;

// --------------- lifecycle -----------------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    getAllLandingData();
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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<AuthProvider>(context, listen: false).loadSavedToken();
    super.didChangeDependencies();
  }

// --------------- method -----------------
  Future<void> getAllLandingData() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<LandingProvider>(context, listen: false).fetchLandingData();
    setState(() {
      _isLoading = false;
    });
  }

  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

// --------------- UI -----------------

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final theme = Theme.of(context);
    final landingProvider = Provider.of<LandingProvider>(context);
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    final lightShadowColors = [Colors.white, Colors.white.withOpacity(0)];
    final darkShadowColors = [theme.scaffoldBackgroundColor, theme.scaffoldBackgroundColor.withOpacity(0)];
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        floatingActionButton: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return FloatingActionButton.extended(
              onPressed: () {
                authProvider.token == null ? Navigator.of(context).pushNamed(AuthScreen.routeName) : Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
              label: Text(authProvider.token == null ? 'ورود' : 'داشبورد', style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white)),
              icon: Icon(authProvider.token == null ? Icons.login : Icons.dashboard, color: Colors.white),
              backgroundColor: Colors.blue,
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: _isLoading
            ? const Center(child: Spinner(size: 40))
            : SafeArea(
                child: Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        const LandingAppBar(),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              const SizedBox(height: 20),
                              NormalSlider(landingProvider.slides),
                              const SizedBox(height: 20),
                              AnnoucementSlider(landingProvider.announcements),
                              const SizedBox(height: 20),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                                  child: Text('اخبار اخیر', style: theme.textTheme.titleMedium),
                                ),
                              ),
                              SizedBox(height: 280, child: NewsList(newsList: landingProvider.news)),
                              const SizedBox(height: 30),
                              Center(child: Text('مدرسان مجرب سازمان', style: theme.textTheme.titleMedium)),
                              const SizedBox(height: 30),
                              const TeachersList(),
                              const SizedBox(height: 15),
                              TmsSlider(landingProvider.tms),
                              const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12, bottom: 15),
                                    child: Text('دوره های شگفت‌انگیز', style: theme.textTheme.titleMedium),
                                  ),
                                ],
                              ),
                              const AmazingCoursesList(),
                              const SizedBox(height: 65),
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
                          height: 110,
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
      ),
    );
  }
}
