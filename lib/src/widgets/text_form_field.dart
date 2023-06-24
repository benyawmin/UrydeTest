import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReportTextFields extends StatelessWidget {
  final int maxLength;
  final TextInputType textInputType;
  final int fieldNumber;
  const ReportTextFields(
      {super.key,
      required this.maxLength,
      required this.textInputType,
      required this.fieldNumber});

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? inputFormatters;

    /* Differentiating between the plate fields and report field
    acceptable inputs
     */
    if (fieldNumber != 3) {
      if (fieldNumber == 2) {
        inputFormatters = [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
          FilteringTextInputFormatter.digitsOnly
        ];
      } else {
        inputFormatters = [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
        ];
      }
    } else {
      inputFormatters = null;
    }

    return TextFormField(
      onSaved: ((newValue) {}),
      validator: (value) {
        if (value == null || value.isEmpty || value.length != maxLength) {
          return '';
        }
        return null;
      },
      inputFormatters: inputFormatters,
      textAlignVertical: TextAlignVertical.top,
      expands: textInputType == TextInputType.multiline ? true : false,
      keyboardType: textInputType,
      maxLength: maxLength,
      maxLines: null,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: textInputType == TextInputType.multiline ? 'Deine infos' : '',
        counterText: '',
        contentPadding: const EdgeInsets.all(8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
