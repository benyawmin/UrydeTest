import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uryde/src/bloc/parking_violations_report_bloc.dart';
import 'package:uryde/src/resources/repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('ParkingViolationsReportBloc', () {
    late ParkingViolationsReportBloc bloc;
    late MockUserRepository userRepository;
    final formKey = GlobalKey<FormState>();

    setUp(() {
      userRepository = MockUserRepository();
      bloc = ParkingViolationsReportBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is ParkingViolationsReportInitial', () {
      expect(bloc.state, ParkingViolationsReportInitial());
    });

    blocTest<ParkingViolationsReportBloc, ParkingViolationsReportState>(
      'emits PlateNumberIsValid when PlateNumberValidation event is added with valid form key',
      build: () => bloc,
      act: (bloc) => bloc.add(PlateNumberValidation(formKey)),
      expect: () => [PlateNumberIsValid()],
    );

    blocTest<ParkingViolationsReportBloc, ParkingViolationsReportState>(
      'emits PlateNumberIsNotValid when PlateNumberValidation event is added with invalid form key',
      build: () => bloc,
      act: (bloc) => bloc.add(PlateNumberValidation(formKey)),
      expect: () => [PlateNumberIsNotValid()],
    );

    blocTest<ParkingViolationsReportBloc, ParkingViolationsReportState>(
      'emits ParkingViolationsReportLoading and ReportRequestSent when SendParkingViolationReport event is added and API request is successful',
      build: () => bloc,
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
      build: () => bloc,
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
