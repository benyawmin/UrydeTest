import 'package:flutter/material.dart';
import 'package:uryde/src/widgets/report_option.dart';

class ReportReasons extends StatefulWidget {
  const ReportReasons({Key? key}) : super(key: key);

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

  Widget reportOption(String optionText, ReportingOptions reportingOptions) {
    return ReportOptionWidget(
      optionText: optionText,
      reportingOption: reportingOptions,
      selectedOption: _option,
      onChanged: (ReportingOptions? value) {
        setState(() {
          _option = value;
        });
      },
    );
  }
}
