import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../screens/login_screen.dart';
import '../widgets/elements/slider/annoucement_slider.dart';
import '../widgets/elements/slider/normal_slider.dart';
import '../providers/Landing/LandingProvider.dart';
import '../widgets/elements/slider/tms_slider.dart';
import '../widgets/elements/slider/teachers_list.dart';
import '../widgets/elements/slider/news_list.dart';
import '../widgets/elements/spinner.dart';
import '../providers/Auth/AuthProvider.dart';
import '../screens/home_screen.dart';

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
// --------------- UI -----------------

  @override
  Widget build(BuildContext context) {
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
          title: const Text('فاواگستر سپهر', style: TextStyle(color: Colors.black, fontSize: 18)),
          backgroundColor: Colors.white,
          actions: [
            Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                return authProvider.token == null
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(LoginScreen.routeName);
                        },
                        child: const Text('ورود', style: TextStyle(fontSize: 14)))
                    : TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(HomeScreen.routeName);
                        },
                        child: const Text(
                          'داشبورد',
                          style: TextStyle(fontSize: 14),
                        ),
                      );
              },
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: Spinner(size: 40))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    NormalSlider(landingProvider.slides),
                    const SizedBox(height: 15),
                    AnnoucementSlider(landingProvider.announcements),
                    const SizedBox(height: 30),
                    SizedBox(height: 320, child: NewsList(newsList: landingProvider.news)),
                    const SizedBox(height: 10),
                    TmsSlider(landingProvider.tms),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: const Text('مدرسین مجرب سازمان', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                      ),
                    ]),
                    const SizedBox(height: 15),
                    TeachersList(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }
}
