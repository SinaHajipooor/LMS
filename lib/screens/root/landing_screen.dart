import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms/helpers/InternetConnectivityHelper.dart';
import 'package:lms/screens/auth/auth_screen.dart';
import 'package:lms/widgets/landing/amazing_courses_list.dart';
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
// --------------- lifecycle -----------------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    getAllLandingData();
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
    final theme = Theme.of(context);
    final landingProvider = Provider.of<LandingProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Text(' یادگیری الکترونیک', style: theme.textTheme.titleLarge),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        floatingActionButton: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return FloatingActionButton.extended(
              onPressed: () {
                authProvider.token == null ? Navigator.of(context).pushNamed(AuthScreen.routeName) : Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
              label: Text(authProvider.token == null ? 'ورود' : 'داشبورد', style: const TextStyle(fontSize: 13)),
              icon: Icon(authProvider.token == null ? Icons.login : Icons.dashboard),
              backgroundColor: Colors.blue,
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: _isLoading
            ? const Center(child: Spinner(size: 40))
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    NormalSlider(landingProvider.slides),
                    const SizedBox(height: 15),
                    TmsSlider(landingProvider.tms),
                    const SizedBox(height: 50),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Text('مدرسان مجرب سازمان', style: theme.textTheme.titleMedium),
                      ),
                    ]),
                    const SizedBox(height: 15),
                    const TeachersList(),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Text('اخبار اخیر', style: theme.textTheme.titleMedium),
                    ),
                    SizedBox(height: 280, child: NewsList(newsList: landingProvider.news)),
                    const SizedBox(height: 20),
                    AnnoucementSlider(landingProvider.announcements),
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
                    const SizedBox(height: 15),
                  ],
                ),
              ),
      ),
    );
  }
}
