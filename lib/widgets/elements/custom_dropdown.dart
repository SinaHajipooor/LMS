import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String placeholder;
  final List<String> items;
  final ValueChanged<String>? onChanged;

  const CustomDropdown({
    Key? key,
    required this.placeholder,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.placeholder;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButton<String>(
          elevation: 1,
          value: _value,
          items: [
            DropdownMenuItem<String>(
              value: widget.placeholder,
              child: Text(widget.placeholder, style: const TextStyle(fontSize: 12)),
            ),
            ...widget.items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }),
          ],
          onChanged: (String? newValue) {
            setState(() {
              _value = newValue;
            });
            if (widget.onChanged != null && newValue != widget.placeholder) {
              widget.onChanged!(newValue!);
            }
          },
          underline: Container(), // Hide default underline
        ),
      ),
    );
  }
}
