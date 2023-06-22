import 'package:flutter/material.dart';

class ReportReasons extends StatefulWidget {
  const ReportReasons({super.key});

  @override
  State<ReportReasons> createState() => _ReportReasonsState();
}

enum ReportingOptions { blocked, obstruct, other }

class _ReportReasonsState extends State<ReportReasons> {
  ReportingOptions? _character = ReportingOptions.blocked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        reportOption('Mein gebuchter Stellplatz ist blockiert',
            ReportingOptions.blocked),
        reportOption('Nebenstehender Pkw behindert meinen Stellplatz',
            ReportingOptions.obstruct),
        reportOption('Sonstiges', ReportingOptions.other),
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
        groupValue: _character,
        onChanged: (ReportingOptions? value) {
          setState(() {
            _character = value;
          });
        },
      ),
    );
  }
}
