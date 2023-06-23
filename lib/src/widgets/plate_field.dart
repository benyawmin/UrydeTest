import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uryde/src/bloc/parking_violations_report_bloc.dart';

class PlateField extends StatelessWidget {
  final int maxLength;
  final TextInputType textInputType;
  final int fieldNumber;
  const PlateField(
      {super.key,
      required this.maxLength,
      required this.textInputType,
      required this.fieldNumber});

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? inputFormatters;

    /* This condition could be written more simple but this way it is more
    readable */
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
        print(value);
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
