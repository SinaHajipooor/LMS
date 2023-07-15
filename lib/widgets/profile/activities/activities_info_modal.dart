import 'package:flutter/material.dart';
import 'package:lms/widgets/profile/activities/activites_info_form.dart';

// ignore: must_be_immutable
class ActivitiesInfoModal extends StatefulWidget {
  final double deviceHeight;
  int? activityId;
  final bool isEditing;
  final bool isCreating;
  final bool isShowing;
  final String title;
  final Function() fetchAllActivities;

  ActivitiesInfoModal({
    required this.deviceHeight,
    required this.fetchAllActivities,
    Key? key,
    this.activityId,
    required this.isEditing,
    required this.isCreating,
    required this.isShowing,
    required this.title,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ActivitiesInfoModalState createState() => _ActivitiesInfoModalState();
}

class _ActivitiesInfoModalState extends State<ActivitiesInfoModal> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final keyboardOffset = MediaQuery.of(context).viewInsets.bottom;
    final theme = Theme.of(context);
    return StatefulBuilder(
      builder: (context, setState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (keyboardOffset > 0) {
            setState(() {
              _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
              );
            });
          }
        });
        return SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(
            bottom: keyboardOffset + MediaQuery.of(context).padding.bottom,
          ),
          child: SizedBox(
            height: widget.deviceHeight * 0.65,
            child: Column(
              children: [
                Container(
                  height: 50, // adjust as needed
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    style: theme.textTheme.titleMedium!.apply(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ActivitiesInfoForm(
                  fetchAllActivities: widget.fetchAllActivities,
                  isCreating: widget.isCreating,
                  isEditing: widget.isEditing,
                  isShowing: widget.isShowing,
                  activityId: widget.activityId,
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
