part of 'parking_violations_report_bloc.dart';

@immutable
abstract class ParkingViolationsReportState extends Equatable {
  /* The equatable boilerplate code that could be used in the future
  in case of feature changes */
  const ParkingViolationsReportState([List props = const []]) : super();
}

class ParkingViolationsReportInitial extends ParkingViolationsReportState {
  @override
  List<Object?> get props => [];
}

class ParkingViolationsReportLoading extends ParkingViolationsReportState {
  @override
  List<Object?> get props => [];
}

class ParkingViolationsReportLoaded extends ParkingViolationsReportState {
  @override
  List<Object?> get props => [];
}

class PlateNumberIsValid extends ParkingViolationsReportState {
  @override
  List<Object?> get props => [];
}

class PlateNumberIsNotValid extends ParkingViolationsReportState {
  @override
  List<Object?> get props => [];
}

class ReportRequestSent extends ParkingViolationsReportState {
  final bool wasApiRequestSuccessful;
  const ReportRequestSent({required this.wasApiRequestSuccessful});

  @override
  List<Object?> get props => [];
}