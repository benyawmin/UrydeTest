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
  List<Object?> get props => [formKey];
}

class SendParkingViolationReport extends ParkingViolationsReportEvent {
  @override
  List<Object?> get props => [];
}

class ReportReasonSelection extends ParkingViolationsReportEvent {
  final String reportReasonSelectedValue;
  const ReportReasonSelection({required this.reportReasonSelectedValue});

  @override
  List<Object?> get props => [reportReasonSelectedValue];
}

class UpdateTextFieldEvent extends ParkingViolationsReportEvent {
  final String textField1;
  final String textField2;
  final String textField3;

  const UpdateTextFieldEvent(this.textField1, this.textField2, this.textField3);
}