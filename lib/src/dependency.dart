import 'package:get_it/get_it.dart';
import 'package:uryde/src/bloc/parking_violations_report_bloc.dart';

final GetIt getIt = GetIt.instance;

void initialize() {
  getIt.registerLazySingleton<ParkingViolationsReportBloc>(
      () => ParkingViolationsReportBloc());
}
