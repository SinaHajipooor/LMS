import 'package:flutter/material.dart';

class UserInformationInput extends StatelessWidget {
  final String value;
  final String label;
  final Function(String) onChanged;
  final TextInputType keyboardType;

  const UserInformationInput({
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                border: InputBorder.none, // Hide default border
              ),
              style: theme.textTheme.bodyMedium!.apply(color: Colors.black, overflow: TextOverflow.ellipsis),
              maxLines: 1,
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
