import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String value;
  final String label;
  final Function(String) onChanged;
  final TextInputType keyboardType;

  const TextInput({
    Key? key,
    required this.value,
    required this.label,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            label,
            style: theme.textTheme.bodySmall,
          ),
        ),
        Card(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none, // Hide default border
              ),
              onChanged: onChanged,
              controller: TextEditingController(text: value),
              keyboardType: keyboardType,
            ),
          ),
        ),
      ],
    );
  }
}
