import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uryde/src/resources/repository.dart';
part 'parking_violations_report_event.dart';
part 'parking_violations_report_state.dart';

// TODO
// Complete it
// REMEMBER TO USE DEPENDENCY INJECTION (GET_IT) IN YOUR CODE TOO
// I WAS LITERALLY USING IT IN MY LAST JOB I JUST FORGOT ABOUT IT

class ParkingViolationsReportBloc
    extends Bloc<ParkingViolationsReportEvent, ParkingViolationsReportState> {
  final UserRepository userRepository = FakeUserRepository();

  ParkingViolationsReportBloc() : super(ParkingViolationsReportInitial()) {
    String reportReason = 'Mein gebuchter Stellplatz ist blockiert';

    // Bloc version 8 and higher Updated as below
    on<ParkingViolationsReportEvent>((event, emit) {
      emit(ParkingViolationsReportInitial());
    });

    on<PlateNumberValidation>((event, emit) {
      if (event.formKey.currentState!.validate()) {
        event.formKey.currentState!.save();
        emit(PlateNumberIsValid());
      } else {
        emit(PlateNumberIsNotValid());
      }
    });

    on<SendParkingViolationReport>((event, emit) async {
      //TODO
      // SEND THE PLATE NUMBER AND REASON INSTEAD OF A DUMMY MAP LATER
      emit(ParkingViolationsReportLoading());
      try {
        await userRepository.sendReport({'ParkingReport': 'Violation'});
        emit(const ReportRequestSent(wasApiRequestSuccessful: true));
      } catch (error) {
        emit(const ReportRequestSent(wasApiRequestSuccessful: false));
      }
    });

    on<ReportReasonSelection>((event, emit) {
      reportReason = event.reportReasonSelectedValue;
      emit(ReportReason(reportReason: reportReason));
    });
  }
}
