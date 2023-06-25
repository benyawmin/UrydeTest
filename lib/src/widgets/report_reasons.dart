import 'package:flutter/material.dart';

class ReportReasons extends StatefulWidget {
  const ReportReasons({super.key});

  @override
  State<ReportReasons> createState() => _ReportReasonsState();
}

enum ReportingOptions { blocked, obstruct, other }

// Setting values of the reporting options
String blockedOptionText = 'Mein gebuchter Stellplatz ist blockiert';
String obstructOptionText = 'Nebenstehender Pkw behindert meinen Stellplatz';
String otherOptionText = 'Sonstiges';

class _ReportReasonsState extends State<ReportReasons> {
  ReportingOptions? _option = ReportingOptions.blocked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        reportOption(blockedOptionText, ReportingOptions.blocked),
        reportOption(obstructOptionText, ReportingOptions.obstruct),
        reportOption(otherOptionText, ReportingOptions.other),
      ],
    );
  }

  ListTile reportOption(String optionText, ReportingOptions reportingOptions) {
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
        value: reportingOptions,
        groupValue: _option,
        onChanged: (ReportingOptions? value) {
          setState(() {
            _option = value;
          });
        },
      ),
    );
  }
}
