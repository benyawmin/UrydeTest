import 'package:flutter/material.dart';
import 'package:uryde/src/widgets/report_reasons.dart';

class ReportOptionWidget extends StatelessWidget {
  final String optionText;
  final ReportingOptions reportingOption;
  final ReportingOptions? selectedOption;
  final ValueChanged<ReportingOptions?> onChanged;

  const ReportOptionWidget({
    super.key,
    required this.optionText,
    required this.reportingOption,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(
        optionText,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.grey),
      ),
      leading: Radio<ReportingOptions>(
        activeColor: Theme.of(context).primaryColor,
        value: reportingOption,
        groupValue: selectedOption,
        onChanged: onChanged,
      ),
    );
  }
}
