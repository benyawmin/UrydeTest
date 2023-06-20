part of 'parking_violations_report_bloc.dart';

@immutable
abstract class ParkingViolationsReportEvent extends Equatable {
  /* The equatable boilerplate code that could be used in the future
  in case of feature changes */
  const ParkingViolationsReportEvent([List props = const []]) : super();

  @override
  List<Object?> get props => [];
}

class TextChanged extends ParkingViolationsReportEvent {
  final String newText;

  const TextChanged(this.newText);

  @override
  List<Object?> get props => [newText];
}
