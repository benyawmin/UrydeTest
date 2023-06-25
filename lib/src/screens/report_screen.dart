// ***** This screen is responsible for report parking violations ***** //
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:uryde/src/dependency.dart';
import 'package:uryde/src/widgets/plate_number.dart';
import 'package:uryde/src/widgets/report_textfields.dart';
import 'package:uryde/src/widgets/show_validation_dialog.dart';
import 'package:uryde/src/widgets/report_reasons.dart';
import '../bloc/parking_violations_report_bloc.dart';

class ReportScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ReportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // This listener can be later used for debug purposes or other purposes
    // If needed
    return BlocProvider(
        create: (context) => getIt.get<ParkingViolationsReportBloc>(),
        child: BlocListener<ParkingViolationsReportBloc,
            ParkingViolationsReportState>(
          listener: (context, state) {
            // if (state is ParkingViolationsReportLoaded) {
            //   // The code beneath is just a showcase for testing
            //   // debugPrint(state.props.toString());
            // }
          },
          child: BlocBuilder<ParkingViolationsReportBloc,
              ParkingViolationsReportState>(
            bloc: getIt.get<ParkingViolationsReportBloc>(),
            builder: (BuildContext context,
                ParkingViolationsReportState parkingViolationsReportState) {
              if (parkingViolationsReportState
                  is ParkingViolationsReportInitial) {
                return buildInitialReport(
                    _formKey, context, parkingViolationsReportState);
              } else if (parkingViolationsReportState
                  is ParkingViolationsReportLoading) {
                return buildLoading();
              } else if (parkingViolationsReportState is PlateNumberIsValid) {
                getIt
                    .get<ParkingViolationsReportBloc>()
                    // Send the plate number and
                    //radio button reason here
                    .add(SendParkingViolationReport());
              } else if (parkingViolationsReportState
                  is PlateNumberIsNotValid) {
                return buildInitialReport(
                    _formKey, context, parkingViolationsReportState);
              } else if (parkingViolationsReportState is ReportRequestSent) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showReportSentDialog(context,
                      parkingViolationsReportState.wasApiRequestSuccessful);
                });
              }
              return const SizedBox();
            },
          ),
        ));
  }
}

buildInitialReport(GlobalKey<FormState> formKey, BuildContext context,
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
            color: Theme.of(context).primaryColor,
            size: 6.h,
          )),
          Center(
            child: Text(
              'Falsch parker melden',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Divider(
            indent: 10.w,
            endIndent: 10.w,
          ),
          Text(
            'Bitte gib das Kennzeichen des falsch parkenden Pkw an:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 2.h,
          ),
          // The plate number row
          PlateNumber(formKey: formKey),
          Wrap(
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Hinweis: ',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(color: Colors.red)),
                    TextSpan(
                      text:
                          '''Wir benachrichten den Fahrer (wenn möglich) und vermerken diesen als Falschparker.''',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: Colors.grey),
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
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const ReportReasons(),
          Text(
            'Anmerkungen: ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
              height: 15.h,
              child: ReportTextFields(
                  maxLength: 200,
                  textInputType: TextInputType.multiline,
                  fieldNumber: 3,
                  context: context)),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 5.h,
              width: 45.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: const StadiumBorder()),
                  onPressed: () {
                    getIt
                        .get<ParkingViolationsReportBloc>()
                        .add(PlateNumberValidation(formKey));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        size: 3.h,
                        Icons.report_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text('Falschparker melden',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(color: Colors.white, fontWeightDelta: 1))
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

// Shows the dialog if the report was send successfully to the api or not
void showReportSentDialog(BuildContext context, bool wasApiRequestSuccessful) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return ShowValidationDialog(
        dialogContext: context,
        wasApiRequestSuccessful: wasApiRequestSuccessful,
      );
    },
  );
}
