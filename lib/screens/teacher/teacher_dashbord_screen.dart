import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/navigation/app_drawer.dart';
import 'package:lms/navigation/bottom_tabas.dart';
import 'package:lms/screens/profile/profile_screen.dart';

class TeacherDashbordScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TeacherDashbordScreen({super.key});

  @override
  State<TeacherDashbordScreen> createState() => _TeacherDashbordScreenState();
}

class _TeacherDashbordScreenState extends State<TeacherDashbordScreen> {
  //----------------- state --------------------
  final _scrollController = ScrollController();
  // ignore: unused_field
  bool _isFabVisible = true;
  //----------------- lifecycle --------------------
  @override
  void initState() {
    super.initState();
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
  }

  //----------------- UI --------------------

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BottomTabs(defaultPageIndex: 1)));
        return false;
      },
      child: Scaffold(
        key: widget._scaffoldKey,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
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
                Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
              },
            ),
          ],
        ),
        drawer: const AppDrawer(),
      ),
    );
  }
}
