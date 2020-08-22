import 'package:bloc_test/bloc_test.dart';
import 'package:curativecare/bloc/compare_screen_bloc/compare_screen/compare_screen_bloc.dart';
import 'package:curativecare/bloc/compare_screen_bloc/compare_screen/compare_screen_event.dart';
import 'package:curativecare/bloc/compare_screen_bloc/compare_screen/compare_screen_state.dart';
import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:curativecare/models/general_information.dart';
import 'package:curativecare/models/patient_experience.dart';
import 'package:curativecare/repository/compare_screen_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCompareScreenRepository extends Mock
    implements CompareScreenRepositoryImpl {}

void main() {
  CompareScreenBloc compareScreenBloc;
  MockCompareScreenRepository mockCompareScreenRepo;

  setUp(() {
    mockCompareScreenRepo = MockCompareScreenRepository();
    compareScreenBloc = CompareScreenBloc(mockCompareScreenRepo);
  });
  tearDown(() {
    compareScreenBloc?.close();
  });

  test('initial state is correct', () {
    expect(compareScreenBloc.initialState, CompareScreenLoadingState());
  });
  group('compareScreenBloc test', () {
    List<CompareHospitalModel> hospitalName = new List();
    hospitalName.add(CompareHospitalModel("Alaska Regional Hospital", false));

    GeneralInformation generalInformation = new GeneralInformation(
        "hospitalName",
        "phoneNumber",
        "hospitalType",
        " hospitalOwnership",
        "emergencyServices",
        "hospitalOverallRating");
    PatientExperience patientExperience = new PatientExperience(
        "hospitalName",
        'communicationWithNursesPerformanceRate',
        "communicationWithDoctorsPerformanceRate",
        "responsivenessOfHospitalStaffPerformanceRate",
        "careTransitionPerformanceRate",
        "communicationAboutMedicinesPerformanceRate",
        "cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate");
    List<GeneralInformation> generalList = new List();
    List<PatientExperience> patientList = new List();
    generalList.add(generalInformation);
    patientList.add(patientExperience);
    blocTest(
      'emits [CompareScreenListLoadingState(),CompareScreenListLoadedState(hospitalName)] when CompareScreenFetchData is added',
      build: () {
        when(mockCompareScreenRepo.fetchGeneralInformation(any))
            .thenAnswer((realInvocation) => Future.value(generalInformation));
        when(mockCompareScreenRepo.fetchPatientExperience(any))
            .thenAnswer((realInvocation) => Future.value(patientExperience));
        return compareScreenBloc;
      },
      act: (bloc) => bloc.add(CompareScreenFetchData(hospitalName)),
      expect: [
        CompareScreenLoadingState(),
        CompareScreenLoadedState(generalList, patientList)
      ],
    );
    blocTest(
      'emits [CompareScreenLoadingState(),CompareScreenErrorState("Error Loading")] when CompareScreenFetchData is added',
      build: () {
        when(mockCompareScreenRepo.fetchGeneralInformation(any))
            .thenAnswer((realInvocation) => Future.value(generalInformation));
        when(mockCompareScreenRepo.fetchPatientExperience(any))
            .thenThrow(Exception("Error Loading"));
        return compareScreenBloc;
      },
      act: (bloc) => bloc.add(CompareScreenFetchData(hospitalName)),
      expect: [
        CompareScreenLoadingState(),
        CompareScreenErrorState("Error Loading")
      ],
    );
  });
}
