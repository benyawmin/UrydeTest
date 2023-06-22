part of 'parking_violations_report_bloc.dart';

@immutable
abstract class ParkingViolationsReportEvent extends Equatable {
  const ParkingViolationsReportEvent([List props = const []]) : super();

  @override
  List<Object?> get props => [];
}

class PlateNumberValidation extends ParkingViolationsReportEvent {
  final GlobalKey<FormState> formKey;
  const PlateNumberValidation(this.formKey);
  @override
  List<Object?> get props => [];
}

class SendParkingViolationReport extends ParkingViolationsReportEvent {
  @override
  List<Object?> get props => [];
}
