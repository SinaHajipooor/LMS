import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String value;
  final String label;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final bool editable;
  const TextInput({
    Key? key,
    required this.value,
    required this.label,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.editable = true,
  }) : super(key: key);
  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            widget.label,
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
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: widget.editable ? widget.onChanged : null,
                    controller: _controller,
                    keyboardType: widget.keyboardType,
                    enabled: widget.editable,
                  ),
                ),
                if (widget.editable && _controller.text.isNotEmpty) // Show clear button only if the input is editable and has text
                  IconButton(
                    icon: const Icon(Icons.clear, size: 18, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _controller.clear(); // Clear the text in the input field
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
