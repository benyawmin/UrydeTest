import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uryde/src/bloc/parking_violations_report_bloc.dart';
import 'package:uryde/src/resources/repository.dart';

// Dependency injection
final GetIt getIt = GetIt.instance;

void initialize() {
  getIt.registerLazySingleton<ParkingViolationsReportBloc>(
      () => ParkingViolationsReportBloc());

  getIt.registerLazySingleton<GlobalKey<FormState>>(
      () => GlobalKey<FormState>());

  getIt.registerLazySingleton<FakeUserRepository>(() => FakeUserRepository());
}
