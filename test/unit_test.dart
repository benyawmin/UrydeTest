import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uryde/src/bloc/parking_violations_report_bloc.dart';
import 'package:uryde/src/dependency.dart';
import 'package:uryde/src/resources/repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initialize();
  group('ParkingViolationsReportBloc', () {
    late MockUserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
    });

    test('initial state is ParkingViolationsReportInitial', () {
      expect(getIt.get<ParkingViolationsReportBloc>().state,
          ParkingViolationsReportInitial());
    });

    // tearDown(() {
    //   getIt.get<ParkingViolationsReportBloc>().close();
    // });

    blocTest<ParkingViolationsReportBloc, ParkingViolationsReportState>(
      'emits PlateNumberIsValid when PlateNumberValidation event is added with valid form key',
      build: () => getIt.get<ParkingViolationsReportBloc>(),
      act: (bloc) {
          bloc.add(PlateNumberValidation(getIt.get<GlobalKey<FormState>>()));
      },
      expect: () => <ParkingViolationsReportState>[PlateNumberIsValid()],
    );

    blocTest<ParkingViolationsReportBloc, ParkingViolationsReportState>(
      'emits PlateNumberIsNotValid when PlateNumberValidation event is added with invalid form key',
      build: () => getIt.get<ParkingViolationsReportBloc>(),
      act: (bloc) =>
          bloc.add(PlateNumberValidation(getIt.get<GlobalKey<FormState>>())),
      expect: () => [PlateNumberIsNotValid()],
    );

    blocTest<ParkingViolationsReportBloc, ParkingViolationsReportState>(
      'emits ParkingViolationsReportLoading and ReportRequestSent when SendParkingViolationReport event is added and API request is successful',
      build: () => getIt.get<ParkingViolationsReportBloc>(),
      act: (bloc) {
        when(userRepository.sendReport({
          'ParkingReport':
              'This is the report with plate number && selected reason'
        })).thenAnswer(
            (_) => Future.value('''Fake API response for ParkingReport:
            This is the report with plate number && selected reason'''));
        bloc.add(SendParkingViolationReport());
      },
      expect: () => [
        ParkingViolationsReportLoading(),
        const ReportRequestSent(wasApiRequestSuccessful: true)
      ],
    );

    blocTest<ParkingViolationsReportBloc, ParkingViolationsReportState>(
      'emits ParkingViolationsReportLoading and ReportRequestSent with wasApiRequestSuccessful=false when SendParkingViolationReport event is added and API request throws an error',
      build: () => getIt.get<ParkingViolationsReportBloc>(),
      act: (bloc) {
        when(userRepository.sendReport({
          'ParkingReport':
              'This is the report with plate number && selected reason'
        })).thenThrow(Exception('API request failed'));
        bloc.add(SendParkingViolationReport());
      },
      expect: () => [
        ParkingViolationsReportLoading(),
        const ReportRequestSent(wasApiRequestSuccessful: false)
      ],
    );
  });
}
