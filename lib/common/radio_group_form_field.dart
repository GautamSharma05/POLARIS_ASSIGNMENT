import 'package:flutter/material.dart';


class RadioGroupFormField extends StatefulWidget {
  final String label;
  final List<String> options;
  final bool mandatory;
  final Function(String?) onOptionSelected; // Callback function

  const RadioGroupFormField({
    super.key,
    required this.label,
    required this.options,
    required this.mandatory,
    required this.onOptionSelected,
  });

  @override
  State<RadioGroupFormField> createState() => _RadioGroupFormFieldState();
}

class _RadioGroupFormFieldState extends State<RadioGroupFormField> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (widget.mandatory)
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        ...widget.options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: _selectedOption,
            onChanged: (String? value) {
              setState(() {
                _selectedOption = value;
                widget.onOptionSelected(value); // Call the callback function
              });
            },
          );
        }),
      ],
    );
  }
}
