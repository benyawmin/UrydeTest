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
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        reportOption(theme, 'Mein gebuchter Stellplatz ist blockiert',
            ReportingOptions.blocked),
        reportOption(theme, 'Nebenstehender Pkw behindert meinen Stellplatz',
            ReportingOptions.obstruct),
        reportOption(theme, 'Sonstiges', ReportingOptions.other),
      ],
    );
  }

  ListTile reportOption(
      ThemeData theme, String optionText, ReportingOptions reportingOptions) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(
        optionText,
        style: theme.textTheme.bodyMedium!.apply(color: Colors.grey),
      ),
      leading: Radio<ReportingOptions>(
        activeColor: theme.primaryColor,
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
