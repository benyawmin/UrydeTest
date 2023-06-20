import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'parking_violations_report_event.dart';
part 'parking_violations_report_state.dart';

class ParkingViolationsReportBloc
    extends Bloc<ParkingViolationsReportEvent, ParkingViolationsReportState> {
  ParkingViolationsReportBloc() : super(ParkingViolationsReportInitial());

  Stream<ParkingViolationsReportState> mapEventToState(
      ParkingViolationsReportEvent event) async* {
    if (event is TextChanged) {
      print(event.newText);
    }
    // if (event is FetchParkingViolationsEvent) {
    //   // Simulating an asynchronous data fetch operation
    //   await Future.delayed(Duration(seconds: 2));

    //   // Emitting a new state with the fetched data
    //   yield ParkingViolationsReportLoaded(data: ['Violation 1', 'Violation 2', 'Violation 3']);
    // }
  }
}
