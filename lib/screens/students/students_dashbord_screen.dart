import 'package:flutter/material.dart';
import 'package:lms/helpers/internet_connectivity_helper.dart';
import 'package:lms/navigation/StudentsPanel/students_panel_drawer.dart';
import 'package:lms/screens/profile/user/user_profile_screen.dart';
import 'package:lms/widgets/dashbord/calender.dart';
import 'package:lms/widgets/dashbord/dashbord_info_cards.dart';

class StudentsDashbordScreen extends StatefulWidget {
// ---------------- feilds -----------------
  static const routeName = '/dashbord-screen';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  StudentsDashbordScreen({super.key});

  @override
  State<StudentsDashbordScreen> createState() => _StudentsDashbordScreenState();
}

class _StudentsDashbordScreenState extends State<StudentsDashbordScreen> {
//----------------- lifecycle --------------------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    super.initState();
  }

// --------------- methods -----------------
  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
              onPressed: () => widget._scaffoldKey.currentState?.openDrawer(),
            ),
          ],
        ),
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(left: 12, top: 10),
              child: Stack(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    radius: 18,
                  ),
                  Positioned(
                    right: -1,
                    top: 20,
                    bottom: 1,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 109, 223, 113),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName);
            },
          ),
        ],
      ),
      drawer: const StudentsPanelDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 5),
            PersianFullCalendar(calendarUsecase: 1, key: UniqueKey()),
            const DashbordInfoCards(),
          ],
        ),
      ),
    );
  }
}
