import 'package:flutter/material.dart';


class CheckBoxesFormField extends StatefulWidget {
  final String label;
  final List<String> options;
  final bool mandatory;
  final Function(List<String>) onOptionsSelected;

  const CheckBoxesFormField({
    super.key,
    required this.label,
    required this.options,
    required this.mandatory,
    required this.onOptionsSelected,
  });

  @override
  State<CheckBoxesFormField> createState() => _CheckBoxesFormFieldState();
}

class _CheckBoxesFormFieldState extends State<CheckBoxesFormField> {
  final List<String> _selectedOptions = [];

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
          return CheckboxListTile(
            title: Text(option),
            value: _selectedOptions.contains(option),
            onChanged: (bool? value) {
              setState(() {
                if (value != null && value) {
                  _selectedOptions.add(option);
                } else {
                  _selectedOptions.remove(option);
                }
                widget.onOptionsSelected(_selectedOptions);
              });
            },
          );
        }),
        const SizedBox(height: 10),
      ],
    );
  }
}
