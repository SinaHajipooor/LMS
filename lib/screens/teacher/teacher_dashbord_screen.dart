import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/navigation/bottom_tabas.dart';
import 'package:lms/widgets/dashbord/calender.dart';
import 'package:lms/widgets/dashbord/dashbord_info_cards.dart';
import 'package:lms/widgets/elements/custom_appbar.dart';
import 'package:lms/widgets/elements/spinner.dart';

class TeacherDashbordScreen extends StatefulWidget {
  const TeacherDashbordScreen({super.key});

  @override
  State<TeacherDashbordScreen> createState() => _TeacherDashbordScreenState();
}

class _TeacherDashbordScreenState extends State<TeacherDashbordScreen> {
  //----------------- state --------------------
  bool _isLoading = false;
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
        body: _isLoading
            ? const Center(child: Spinner(size: 40))
            : Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      const CustomAppbar(title: 'داشبورد'),
                      SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            const DashbordInfoCards(),
                            const SizedBox(height: 15),
                            const Divider(),
                            const SizedBox(height: 10),
                            PersianFullCalendar(
                              key: UniqueKey(),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
