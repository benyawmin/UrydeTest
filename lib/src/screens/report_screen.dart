// ***** This screen is responsible for report parking violations ***** //
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uryde/src/dependency.dart';
import 'package:uryde/src/widgets/build_initial_report.dart';
import 'package:uryde/src/widgets/build_loading.dart';
import 'package:uryde/src/widgets/show_validation_dialog.dart';
import '../bloc/parking_violations_report_bloc.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});
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
                return const BuildInitialReport();
              } else if (parkingViolationsReportState
                  is ParkingViolationsReportLoading) {
                return const BuildLoading();
              } else if (parkingViolationsReportState is PlateNumberIsValid) {
                getIt
                    .get<ParkingViolationsReportBloc>()
                    // Send the plate number and
                    //radio button reason here
                    .add(SendParkingViolationReport());
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
