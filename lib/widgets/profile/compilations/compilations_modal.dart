import 'package:flutter/material.dart';
import 'package:lms/widgets/profile/compilations/compilations_form.dart';

// ignore: must_be_immutable
class CompilationsModal extends StatefulWidget {
  final String title;
  final bool isEditing;
  final bool isCreating;
  final bool isShowing;
  int? compilationId;
  final double deviceHeight;

  CompilationsModal({
    super.key,
    this.compilationId,
    required this.deviceHeight,
    required this.title,
    required this.isEditing,
    required this.isCreating,
    required this.isShowing,
  });

  @override
  State<CompilationsModal> createState() => _CompilationsModalState();
}

class _CompilationsModalState extends State<CompilationsModal> {
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
                    child: CompilationsForm(
                  isCreating: widget.isCreating,
                  isEditing: widget.isEditing,
                  isShowing: widget.isShowing,
                  compilationId: widget.compilationId,
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
