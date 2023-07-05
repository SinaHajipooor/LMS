import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                  onTap: () {},
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
