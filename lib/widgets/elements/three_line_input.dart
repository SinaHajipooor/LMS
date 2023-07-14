import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ThreeLineInput extends StatefulWidget {
  final String label;
  final Function(String) onChanged;
  final TextEditingController controller;
  bool? editable;
  ThreeLineInput({
    Key? key,
    this.editable,
    required this.controller,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ThreeLineInput> createState() => _ThreeLineInputState();
}

class _ThreeLineInputState extends State<ThreeLineInput> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Text(
            widget.label,
            style: theme.textTheme.bodySmall,
          ),
        ),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              enabled: widget.editable ?? true,
              controller: widget.controller,
              style: theme.textTheme.bodyMedium,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: widget.onChanged,
              maxLines: 3,
            ),
          ),
        ),
      ],
    );
  }
}
