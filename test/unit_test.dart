import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uryde/src/bloc/parking_violations_report_bloc.dart';
import 'package:uryde/src/dependency.dart';
import 'package:uryde/src/resources/api.dart';
import 'package:uryde/src/resources/repository.dart';

class MockApi extends Mock implements Api {}

class MockUserRepository extends Mock implements UserRepository {}

@GenerateMocks([MockUserRepository, MockApi])
void main() {
  group('ParkingViolationsReportBloc', () {
    WidgetsFlutterBinding.ensureInitialized();
    initialize();
    late ParkingViolationsReportBloc bloc;
    late MockUserRepository mockUserRepository;
    late GlobalKey<FormState> formKey;
    late MockApi mockApi;
    setUp(() {
      mockUserRepository = MockUserRepository();
      bloc = getIt.get<ParkingViolationsReportBloc>();
      formKey = getIt.get<GlobalKey<FormState>>();
      mockApi = MockApi();
    });

    test('initial state is ParkingViolationsReportInitial', () {
      expect(bloc.state, ParkingViolationsReportInitial());
    });

    test('formKey is same formKey as the Form widget', () {
      expect(formKey, getIt.get<GlobalKey<FormState>>());
    });

    blocTest<ParkingViolationsReportBloc, ParkingViolationsReportState>(
      'emits PlateNumberIsValid when PlateNumberValidation event is added with valid form key',
      build: () => bloc,
      act: (bloc) {
        when(formKey.currentState!.validate()).thenReturn(true);
        bloc.add(PlateNumberValidation(getIt.get<GlobalKey<FormState>>()));
      },
      expect: () => [PlateNumberIsValid()],
    );

    blocTest<ParkingViolationsReportBloc, ParkingViolationsReportState>(
      'emits PlateNumberIsNotValid when PlateNumberValidation event is added with invalid form key',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(PlateNumberValidation(getIt.get<GlobalKey<FormState>>())),
      expect: () => [ParkingViolationsReportInitial()],
    );

    blocTest<ParkingViolationsReportBloc, ParkingViolationsReportState>(
      'emits ParkingViolationsReportLoading and ReportRequestSent when SendParkingViolationReport event is added and API request is successful',
      build: () => bloc,
      act: (bloc) {
        when(mockApi.sendReport({
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
        when(mockApi.sendReport({
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
