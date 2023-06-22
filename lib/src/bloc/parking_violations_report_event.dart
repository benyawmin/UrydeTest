part of 'parking_violations_report_bloc.dart';

@immutable
abstract class ParkingViolationsReportEvent extends Equatable {
  const ParkingViolationsReportEvent([List props = const []]) : super();

  @override
  List<Object?> get props => [];
}

class PlateField0 extends ParkingViolationsReportEvent {
  final String plateField0;
  const PlateField0(this.plateField0);
  @override
  List<Object?> get props => [];
}

class PlateField1 extends ParkingViolationsReportEvent {
  final String plateField1;
  const PlateField1(this.plateField1);
  @override
  List<Object?> get props => [];
}

class PlateField2 extends ParkingViolationsReportEvent {
  final String plateField2;
  const PlateField2(this.plateField2);
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
