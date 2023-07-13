import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInput extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;
  bool? editable;
  final Function(String) onChanged;
  TextInput({
    Key? key,
    required this.label,
    required this.keyboardType,
    required this.controller,
    this.editable,
    required this.onChanged,
  }) : super(key: key);
  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Card(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
                    keyboardType: widget.keyboardType,
                    controller: widget.controller,
                    enabled: widget.editable ?? true,
                    onChanged: widget.onChanged,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
