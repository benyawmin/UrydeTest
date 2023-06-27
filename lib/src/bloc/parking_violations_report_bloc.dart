import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uryde/src/dependency.dart';
import 'package:uryde/src/resources/repository.dart';
part 'parking_violations_report_event.dart';
part 'parking_violations_report_state.dart';

class ParkingViolationsReportBloc
    extends Bloc<ParkingViolationsReportEvent, ParkingViolationsReportState> {
  ParkingViolationsReportBloc() : super(ParkingViolationsReportInitial()) {
    // Bloc version 8 and higher Updated as below
    on<ParkingViolationsReportEvent>((event, emit) {
      emit(ParkingViolationsReportInitial());
    });

    // change state based on validity of the entered data
    on<PlateNumberValidation>((event, emit) {
      if (event.formKey.currentState!.validate()) {
        event.formKey.currentState!.save();
        emit(PlateNumberIsValid());
      } else {
        emit(ParkingViolationsReportInitial());
      }
    });

    // Sending the report to the API
    on<SendParkingViolationReport>((event, emit) async {
      emit(ParkingViolationsReportLoading());
      try {
        await getIt.get<FakeUserRepository>().sendReport({
          'ParkingReport':
              'This is the report with plate number && selected reason'
        });
        emit(const ReportRequestSent(wasApiRequestSuccessful: true));
      } catch (error) {
        emit(const ReportRequestSent(wasApiRequestSuccessful: false));
      }
    });
  }
}
