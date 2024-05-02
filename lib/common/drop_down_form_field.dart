import 'package:flutter/material.dart';
import 'package:polaris/constant/app_text.dart';

class DropDownFormField extends StatefulWidget {
  final String label;
  final List<String> options;
  final bool mandatory;
  final Function(String?) onOptionSelected;

  const DropDownFormField({
    Key? key, // Add Key parameter here
    required this.label,
    required this.options,
    required this.mandatory,
    required this.onOptionSelected,
  }) : super(key: key); // Assign the key parameter to the super constructor

  @override
  State<DropDownFormField> createState() => _DropDownFormFieldState();
}

class _DropDownFormFieldState extends State<DropDownFormField> {
  String? _selectedOption;
  String? _errorMessage;

  void clearOption() {
    setState(() {
      _selectedOption = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: widget.label,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              errorText: _errorMessage,
            ),
            items: widget.options.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
              widget.onOptionSelected(value);
            },
            validator: (value) {
              if (widget.mandatory && value == null) {
                return AppText.fieldRequired;
              }
              return null;
            },
            value: _selectedOption,
            isExpanded: true,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
