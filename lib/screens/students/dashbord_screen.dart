import 'package:flutter/material.dart';
import 'package:lms/navigation/students_panel_drawer.dart';
import 'package:lms/screens/profile/user_profile_screen.dart';
import 'package:lms/widgets/dashbord/calender.dart';
import 'package:lms/widgets/dashbord/dashbord_info_cards.dart';

class DashbordScreen extends StatefulWidget {
// ---------------- feilds -----------------
  static const routeName = '/dashbord-screen';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DashbordScreen({super.key});

  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
// --------------- methods -----------------

// --------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.blue),
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
            PersianFullCalendar(
              calendarUsecase: 1,
              key: UniqueKey(),
            ),
            const DashbordInfoCards(),
          ],
        ),
      ),
    );
  }
}