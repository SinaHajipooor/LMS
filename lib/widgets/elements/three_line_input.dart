import 'package:flutter/material.dart';

class ThreeLineInput extends StatelessWidget {
  final String value;
  final String label;
  final Function(String) onChanged;

  const ThreeLineInput({
    Key? key,
    required this.value,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Text(
            label,
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
              style: theme.textTheme.bodyMedium,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (value) => onChanged('$value\n${value.split('\n')[1]}\n${value.split('\n')[2]}'),
              controller: TextEditingController(text: value.split('\n').length == 3 ? value : '$value\n\n'),
              maxLines: 4,
            ),
          ),
        ),
      ],
    );
  }
}
