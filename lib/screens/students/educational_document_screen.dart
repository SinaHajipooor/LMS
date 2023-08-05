import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/helpers/connections/internet_connectivity_helper.dart';
import 'package:lms/navigation/StudentsPanel/bottomTab/students_bottom_tabas.dart';
import 'package:lms/widgets/dashbord/dashbord_info_cards.dart';
import 'package:lms/widgets/elements/custom_appbar.dart';
import 'package:lms/widgets/elements/spinner.dart';

class EducationalDocumentScreen extends StatefulWidget {
  const EducationalDocumentScreen({super.key});

  @override
  State<EducationalDocumentScreen> createState() => _EducationalDocumentScreenState();
}

class _EducationalDocumentScreenState extends State<EducationalDocumentScreen> {
  // ----------------- state ----------------------
  bool _isLoading = false;
  final _scrollController = ScrollController();
  // ignore: unused_field
  bool _isFabVisible = true;
  // ----------------- lifecycle ----------------------

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
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

  // --------------- methods -----------------
  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }
  // ----------------- UI ----------------------

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const StudentsBottomTabs(defaultPageIndex: 2)));
        return false;
      },
      child: Scaffold(
        body: _isLoading
            ? const Center(
                child: Spinner(size: 40),
              )
            : Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    slivers: const [
                      CustomAppbar(title: 'پرونده آموزشی'),
                      SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            DashbordInfoCards(),
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
