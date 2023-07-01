import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uryde/src/bloc/parking_violations_report_bloc.dart';
import 'package:uryde/src/dependency.dart';
import 'package:uryde/src/widgets/plate_number.dart';
import 'package:uryde/src/widgets/report_reasons.dart';
import 'package:uryde/src/widgets/report_textfields.dart';

class BuildInitialReport extends StatelessWidget {
  const BuildInitialReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              color: Colors.green,
              size: 6.h,
            )),
            Center(
              child: Text(
                'Falsch parker melden',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Colors.green),
              ),
            ),
            Divider(
              indent: 10.w,
              endIndent: 10.w,
            ),
            Text(
              'Bitte gib das Kennzeichen des falsch parkenden Pkw an:',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.green),
            ),
            SizedBox(
              height: 2.h,
            ),
            // The plate number row
            const PlateNumber(),
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
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.green),
            ),
            const ReportReasons(),
            Text(
              'Anmerkungen: ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.green),
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
                height: 15.h,
                child: ReportTextField(
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
                        backgroundColor: Colors.green,
                        shape: const StadiumBorder()),
                    onPressed: () {
                      getIt.get<ParkingViolationsReportBloc>().add(
                          PlateNumberValidation(
                              getIt.get<GlobalKey<FormState>>()));
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
}
