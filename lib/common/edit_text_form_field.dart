import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polaris/constant/app_text.dart';

class EditTextFormField extends StatefulWidget {
  final String label;
  final String inputType;
  final bool mandatory;
  final TextEditingController controller;

  const EditTextFormField({super.key, required this.label, required this.inputType, required this.mandatory, required this.controller});

  @override
  State<EditTextFormField> createState() => _EditTextFormFieldState();
}

class _EditTextFormFieldState extends State<EditTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      inputFormatters: [
        widget.inputType == 'INTEGER' ? LengthLimitingTextInputFormatter(10) : LengthLimitingTextInputFormatter(40),
      ],
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      keyboardType: widget.inputType == 'INTEGER' ? TextInputType.number : TextInputType.text,
      validator: widget.mandatory ? (value) => value!.isEmpty ? AppText.fieldRequired : null : null,
    );
  }
}
