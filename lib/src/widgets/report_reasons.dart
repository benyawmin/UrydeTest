import 'package:flutter/material.dart';
import 'package:uryde/src/bloc/parking_violations_report_bloc.dart';

class ReportReasons extends StatefulWidget {
  // TODO
  // USE GETIT instead of passing the bloc to child like this
  // OR just create an instance here in build context
  final ParkingViolationsReportBloc parkingViolationsReportBloc;
  const ReportReasons({super.key, required this.parkingViolationsReportBloc});

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
          // TODO
          // This should be moved to main screen because its only on changed here!
          widget.parkingViolationsReportBloc.add(
              ReportReasonSelection(reportReasonSelectedValue: optionText));
        },
      ),
    );
  }
}
