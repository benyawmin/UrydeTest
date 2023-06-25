part of 'parking_violations_report_bloc.dart';

@immutable
abstract class ParkingViolationsReportEvent extends Equatable {
  const ParkingViolationsReportEvent([List props = const []]) : super();

  @override
  List<Object?> get props => [];
}

// Checks if the platenumber entered by user is valid or not
class PlateNumberValidation extends ParkingViolationsReportEvent {
  final GlobalKey<FormState> formKey;
  const PlateNumberValidation(this.formKey);
  @override
  List<Object?> get props => [formKey];
}

// sending the report with the data entered
class SendParkingViolationReport extends ParkingViolationsReportEvent {
  @override
  List<Object?> get props => [];
}
