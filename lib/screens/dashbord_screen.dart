import 'package:flutter/material.dart';
import 'package:lms/widgets/dashbord/calender.dart';
import '../navigation/app_drawer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../providers/Auth/AuthProvider.dart';
import 'package:provider/provider.dart';
import './landing_screen.dart';

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
  _showAlert(BuildContext context) {
    Alert(
            context: context,
            type: AlertType.warning,
            title: "خروج از حساب ",
            desc: "آیا مطمعن هستید که از حساب خود خارج می‌شوید ؟",
            style: AlertStyle(
              titleStyle: const TextStyle(fontWeight: FontWeight.bold),
              descStyle: const TextStyle(fontSize: 14),
              overlayColor: Colors.black.withOpacity(0.6),
              animationType: AnimationType.grow,
              alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide.none),
            ),
            buttons: [
              DialogButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
                },
                width: 120,
                color: Colors.green,
                child: const Text("بله", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              DialogButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                width: 120,
                color: Colors.red[400],
                child: const Text("خیر", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
            closeIcon: const Icon(Icons.close, color: Colors.red))
        .show();
  }

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
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => widget._scaffoldKey.currentState?.openDrawer(),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              showMenu(
                elevation: 1,
                context: context,
                position: const RelativeRect.fromLTRB(0.0, 80.0, 1000.0, 0.0),
                items: [
                  PopupMenuItem(
                    child: Stack(
                      children: [
                        const ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 1.5, vertical: 0),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/avatar.png'),
                            radius: 16,
                          ),
                          title: Text('سینا‌حاجی‌پور', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          subtitle: Text('فراگیر', style: TextStyle(fontSize: 12)),
                        ),
                        Positioned(
                          right: 28,
                          top: 18,
                          bottom: 1,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 109, 223, 113),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.settings, size: 20, color: Colors.blue),
                      title: Text('تنظیمات', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () => _showAlert(context),
                      child: const ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.logout, size: 20, color: Colors.red),
                        title: Text('خروج', style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                ],
              );
            },
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
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: PersianFullCalendar(),
    );
  }
}
