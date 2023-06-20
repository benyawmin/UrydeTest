import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uryde/src/bloc/parking_violations_report_bloc.dart';

// TODO
// restrict input type with filtering
class PlateField extends StatelessWidget {
  final int maxLength;
  final TextInputType textInputType;
  const PlateField(
      {super.key, required this.maxLength, required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final parkingViolationsReportBloc =
        BlocProvider.of<ParkingViolationsReportBloc>(context);

    return TextField(
      onChanged: (newText) =>
          parkingViolationsReportBloc.add(TextChanged(newText)),
      textAlignVertical: TextAlignVertical.top,
      expands: textInputType == TextInputType.multiline ? true : false,
      keyboardType: textInputType,
      maxLength: maxLength,
      maxLines: null,
      style: TextStyle(color: theme.primaryColor),
      decoration: InputDecoration(
        hintText: textInputType == TextInputType.multiline ? 'Deine infos' : '',
        counterText: '',
        contentPadding: const EdgeInsets.all(8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
