import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/helpers/InternetConnectivityHelper.dart';
import 'package:lms/navigation/TeachersPanel/teachers_bottom_tabs.dart';
import 'package:lms/widgets/elements/custom_appbar.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/teachersPanel/presence_list.dart';

class PresenceScreen extends StatefulWidget {
  static const routeName = '/presence-screen';
  const PresenceScreen({super.key});

  @override
  State<PresenceScreen> createState() => _PresenceScreenState();
}

class _PresenceScreenState extends State<PresenceScreen> {
  // ---------------  state  -------------------
  bool _isLoading = false;
  final _scrollController = ScrollController();
  bool _isFabVisible = true;
  // ----------------  lifecycle  ----------------

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
  // ---------------  methods ---------------

  void _showConfirmationAlert(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: 'پایان حضور غیاب',
      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      titleTextStyle: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 17),
      desc: 'آیا از ثبت لیست حضور غیاب اطمینان دارید ؟',
      descTextStyle: const TextStyle(fontSize: 13),
      btnCancelColor: Colors.red,
      btnOkColor: Colors.blue,
      btnOkText: 'بله',
      buttonsBorderRadius: BorderRadius.circular(9),
      btnCancelText: 'لغو',
      buttonsTextStyle: const TextStyle(fontSize: 15),
      btnCancelOnPress: () => Navigator.of(context).pop(),
      btnOkOnPress: () {
        var snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('گزارش با موفقیت ثبت شد', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white, fontSize: 14)),
          duration: const Duration(seconds: 3),
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const TeachersBottomTabs(defaultPageIndex: 0)));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    ).show();
  }

  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  //---------------- UI ------------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        floatingActionButton: _isLoading
            ? null
            : AnimatedOpacity(
                opacity: _isFabVisible ? 1 : 0,
                duration: const Duration(microseconds: 200),
                child: InkWell(
                  onTap: () => _showConfirmationAlert(context),
                  child: Container(
                    width: 80,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(blurRadius: 20, color: Colors.green.withOpacity(0.5)),
                      ],
                    ),
                    child: const Center(child: Text('ثبت', style: TextStyle(color: Colors.white, fontSize: 14))),
                  ),
                ),
              ),
        body: _isLoading
            ? const Center(child: Spinner(size: 35))
            : Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    slivers: [
                      const CustomAppbar(title: 'لیست حضور و غیاب'),
                      SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            SizedBox(
                              height: deviceSize.height,
                              child: const PresenceList(),
                            ),
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
