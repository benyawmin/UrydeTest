part of 'parking_violations_report_bloc.dart';

@immutable
abstract class ParkingViolationsReportState extends Equatable {
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
