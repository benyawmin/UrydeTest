// ***** This screen is responsible for report parking violations ***** //

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:uryde/src/widgets/plate_field.dart';
import 'package:uryde/src/widgets/report_reasons.dart';
import '../bloc/parking_violations_report_bloc.dart';

class Reservation extends StatelessWidget {
  const Reservation({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    /* This listener can be later used for debug purposes or other purposes
     If needed */
    return BlocProvider(
        create: (context) => ParkingViolationsReportBloc(),
        child: BlocListener<ParkingViolationsReportBloc,
            ParkingViolationsReportState>(
          listener: (context, state) {
            if (state is ParkingViolationsReportLoaded) {
              // The code beneath is just a showcase
              // debugPrint(state.props.toString());
            }
          },
          child: BlocBuilder<ParkingViolationsReportBloc,
              ParkingViolationsReportState>(
            bloc: ParkingViolationsReportBloc(),
            builder: (context, state) {
              if (state is ParkingViolationsReportInitial) {
                return buildInitialReport(theme);
              } else if (state is ParkingViolationsReportLoading) {
                return buildLoading();
              } else if (state is ParkingViolationsReportLoaded) {
                return buildReportDone();
              }
              return const SizedBox();
            },
          ),
        ));
  }
}

buildInitialReport(ThemeData theme) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              _buildTextField(
                responsiveWidth: 14,
                responsiveHeight: 8,
                maxLength: 3,
                textInputType: TextInputType.name,
              ),
              const Text(' - '),
              _buildTextField(
                responsiveWidth: 10,
                responsiveHeight: 8,
                maxLength: 2,
                textInputType: TextInputType.name,
              ),
              const Text(' - '),
              _buildTextField(
                responsiveWidth: 16,
                responsiveHeight: 8,
                maxLength: 5,
                textInputType: TextInputType.number,
              ),
            ],
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
          _buildTextField(
            maxLength: 200,
            responsiveHeight: 15,
            textInputType: TextInputType.multiline,
          ),
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
                  onPressed: () {},
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

// This Screen will be shown when the report button was pressed
Widget buildReportDone() {
  return const Center(
    child: Row(
      children: [
        // If request to the API (stream) was sent successfuly (sending the report)
        Icon(
          Icons.check_outlined,
          color: Colors.green,
        ),
        Text('Driver was successfully reported'),
        // If request to the API (stream) was not sent successfuly (sending the report)
        Icon(
          Icons.cancel_outlined,
          color: Colors.red,
        ),
        Text('Driver was successfully reported')
      ],
    ),
  );
}

// TextField builder based on if it is plate number or the report text
Widget _buildTextField({
  double? responsiveWidth,
  double? responsiveHeight,
  required int maxLength,
  required TextInputType textInputType,
}) {
  return SizedBox(
    width: responsiveWidth?.h,
    height: responsiveHeight?.h,
    child: PlateField(
      maxLength: maxLength,
      textInputType: textInputType,
    ),
  );
}
