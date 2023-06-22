// ***** This screen is responsible for report parking violations ***** //
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:uryde/src/widgets/plate_field.dart';
import 'package:uryde/src/widgets/report_reasons.dart';
import '../bloc/parking_violations_report_bloc.dart';

class ReportScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ReportScreen({super.key});

  final parkingViolationsReportBloc = ParkingViolationsReportBloc();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    /* This listener can be later used for debug purposes or other purposes
     If needed */
    return BlocProvider(
        create: (context) => parkingViolationsReportBloc,
        child: BlocListener<ParkingViolationsReportBloc,
            ParkingViolationsReportState>(
          listener: (context, state) {
            if (state is ParkingViolationsReportLoaded) {
              // The code beneath is just a showcase for testing
              // debugPrint(state.props.toString());
            }
          },
          child: BlocBuilder<ParkingViolationsReportBloc,
              ParkingViolationsReportState>(
            bloc: parkingViolationsReportBloc,
            builder: (BuildContext context,
                ParkingViolationsReportState parkingViolationsReportState) {
              if (parkingViolationsReportState
                  is ParkingViolationsReportInitial) {
                return buildInitialReport(theme, _formKey, context,
                    parkingViolationsReportBloc, parkingViolationsReportState);
              } else if (parkingViolationsReportState
                  is ParkingViolationsReportLoading) {
                return buildLoading();
              } else if (parkingViolationsReportState
                  is ParkingViolationsReportLoaded) {
                // return buildReportDone();
              } else if (parkingViolationsReportState is PlateNumberIsValid) {
                parkingViolationsReportBloc.add(SendParkingViolationReport());
                // TODO
                // Change State based on the result (failed or successful)
                // Loaded
              } else if (parkingViolationsReportState
                  is PlateNumberIsNotValid) {
                return buildInitialReport(theme, _formKey, context,
                    parkingViolationsReportBloc, parkingViolationsReportState);
                // TODO
                // Show the red fields
              } else if (parkingViolationsReportState is ReportRequestSent) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showValidationDialog(context, theme,
                      parkingViolationsReportState.wasApiRequestSuccessful);
                });
              }
              return const SizedBox();
            },
          ),
        ));
  }
}

buildInitialReport(
    ThemeData theme,
    GlobalKey<FormState> formKey,
    BuildContext context,
    ParkingViolationsReportBloc parkingViolationsReportBloc,
    ParkingViolationsReportState parkingViolationsReportState) {
  return Padding(
    padding: EdgeInsets.all(2.h),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Center(
              child: Icon(
            Icons.report,
            color: theme.primaryColor,
            size: 6.h,
          )),
          Center(
            child: Text(
              'Falsch parker melden',
              style: TextStyle(color: theme.primaryColor),
            ),
          ),
          Divider(
            indent: 10.w,
            endIndent: 10.w,
          ),
          Text(
            'Bitte gib das Kennzeichen des falsch parkenden Pkw an:',
            style: TextStyle(color: theme.primaryColor),
          ),
          SizedBox(
            height: 2.h,
          ),
          // The plate number row
          Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                SizedBox(
                    width: 14.h,
                    height: 8.h,
                    child: const PlateField(
                        maxLength: 3,
                        textInputType: TextInputType.name,
                        fieldNumber: 0)),
                const Text(' - '),
                SizedBox(
                    width: 10.h,
                    height: 8.h,
                    child: const PlateField(
                        maxLength: 2,
                        textInputType: TextInputType.name,
                        fieldNumber: 1)),
                const Text(' - '),
                SizedBox(
                    width: 16.h,
                    height: 8.h,
                    child: const PlateField(
                        maxLength: 5,
                        textInputType: TextInputType.number,
                        fieldNumber: 2)),
              ],
            ),
          ),
          Wrap(
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hinweis: ',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: theme.textTheme.bodySmall!.fontSize,
                      ),
                    ),
                    TextSpan(
                      text:
                          '''Wir benachrichten den Fahrer (wenn möglich) und vermerken diesen als Falschparker.''',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: theme.textTheme.bodySmall!.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            'Wähle den Grund Deiner Meldung:',
            style: TextStyle(color: theme.primaryColor),
          ),
          const ReportReasons(),
          Text(
            'Anmerkungen: ',
            style: TextStyle(color: theme.primaryColor),
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
              height: 15.h,
              child: const PlateField(
                  maxLength: 200,
                  textInputType: TextInputType.multiline,
                  fieldNumber: 3)),
          SizedBox(height: 1.h),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 5.h,
              width: 45.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: const StadiumBorder()),
                  onPressed: () {
                    // TODO
                    parkingViolationsReportBloc
                        .add(PlateNumberValidation(formKey));

                    if (parkingViolationsReportState is PlateNumberIsValid) {
                      print(parkingViolationsReportState);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.report_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        'Falschparker melden',
                        style: theme.textTheme.bodySmall!
                            .apply(color: Colors.white, fontWeightDelta: 1),
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildLoading() {
  return const Center(child: CircularProgressIndicator());
}

void showValidationDialog(
    BuildContext context, ThemeData theme, bool wasApiRequestSuccessful) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Card(
        child: AlertDialog(
          title: Text(
            'Report status',
            style: theme.textTheme.titleSmall,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              wasApiRequestSuccessful
                  ? Text(
                      'Driver reported successfully',
                      style: theme.textTheme.bodySmall,
                    )
                  : Text(
                      'Something went wrong',
                      style: theme.textTheme.bodySmall,
                    ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}
