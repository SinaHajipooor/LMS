import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String value;
  final String placeholder;
  final Function(String) onChanged;
  final TextInputType keyboardType;

  const TextInput({
    Key? key,
    required this.value,
    required this.placeholder,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(fontSize: 12),
            border: InputBorder.none, // Hide default border
          ),
          onChanged: onChanged,
          controller: TextEditingController(text: value),
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
