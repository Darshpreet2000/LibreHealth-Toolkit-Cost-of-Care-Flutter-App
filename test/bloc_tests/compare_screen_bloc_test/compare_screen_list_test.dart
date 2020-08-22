import 'package:bloc_test/bloc_test.dart';
import 'package:curativecare/bloc/compare_screen_bloc/compare_screen_list/compare_screen_list_bloc.dart';
import 'package:curativecare/bloc/compare_screen_bloc/compare_screen_list/compare_screen_list_event.dart';
import 'package:curativecare/bloc/compare_screen_bloc/compare_screen_list/compare_screen_list_state.dart';
import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:curativecare/repository/compare_screen_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCompareScreenRepository extends Mock
    implements CompareScreenRepositoryImpl {}

void main() {
  CompareScreenListBloc compareScreenBloc;
  MockCompareScreenRepository mockCompareScreenRepo;

  setUp(() {
    mockCompareScreenRepo = MockCompareScreenRepository();
    compareScreenBloc = CompareScreenListBloc(mockCompareScreenRepo);
    compareScreenBloc.hospitalsAddedToCompare = 2;
  });
  tearDown(() {
    compareScreenBloc?.close();
  });

  test('initial state is correct', () {
    expect(compareScreenBloc.initialState, CompareScreenListLoadingState());
  });
  group('compareScreenBloc test', () {
    List<CompareHospitalModel> hospitalName = new List();
    hospitalName.add(CompareHospitalModel("Alaska Regional Hospital", false));

    List<CompareHospitalModel> hospitalNameUpdated = new List();
    hospitalNameUpdated
        .add(CompareHospitalModel("Alaska Regional Hospital", true));
    blocTest(
      'emits [CompareScreenListLoadingState(),CompareScreenListLoadedState(hospitalName)] when ViewCDMStatewiseFetchStates is added',
      build: () {
        when(mockCompareScreenRepo.checkSavedList())
            .thenAnswer((realInvocation) => Future.value(false));
        when(mockCompareScreenRepo.saveList(any))
            .thenAnswer((realInvocation) => Future.value(0));
        when(mockCompareScreenRepo.getListOfHospitals())
            .thenAnswer((realInvocation) => Future.value(hospitalName));
        return compareScreenBloc;
      },
      act: (bloc) => bloc.add(CompareScreenListFetchHospitalName()),
      expect: [
        CompareScreenListLoadingState(),
        CompareScreenListLoadedState(hospitalName)
      ],
    );
    blocTest(
      'emits [CompareScreenListLoadingState(),CompareScreenListLoadedState(hospitalName)] when ViewCDMStatewiseFetchStates is added',
      build: () {
        when(mockCompareScreenRepo.checkSavedList())
            .thenAnswer((realInvocation) => Future.value(false));
        when(mockCompareScreenRepo.saveList(any))
            .thenAnswer((realInvocation) => Future.value(0));
        when(mockCompareScreenRepo.getListOfHospitals())
            .thenThrow(Exception("Network Error"));
        return compareScreenBloc;
      },
      act: (bloc) => bloc.add(CompareScreenListFetchHospitalName()),
      expect: [
        CompareScreenListLoadingState(),
        CompareScreenListErrorState("Network Error")
      ],
    );

    blocTest(
      'emits [] when   CompareScreenListCompareButtonEvent is added',
      build: () {
        when(mockCompareScreenRepo.checkSavedList())
            .thenAnswer((realInvocation) => Future.value(false));
        when(mockCompareScreenRepo.saveList(any))
            .thenAnswer((realInvocation) => Future.value(0));
        when(mockCompareScreenRepo.getListOfHospitals())
            .thenAnswer((realInvocation) => Future.value(hospitalName));
        compareScreenBloc.hospitalsAddedToCompare = 2;
        return compareScreenBloc;
      },
      act: (bloc) {
        bloc.add(CompareScreenListFetchHospitalName());
        bloc.add(CompareScreenListCompareButtonEvent(false, 0));
      },
      expect: [
        CompareScreenListLoadingState(),
        CompareScreenListLoadedState(hospitalName)
      ],
    );
    blocTest(
      'emits [] when   CompareScreenListCompareButtonError is added',
      build: () {
        when(mockCompareScreenRepo.checkSavedList())
            .thenAnswer((realInvocation) => Future.value(false));
        when(mockCompareScreenRepo.saveList(any))
            .thenAnswer((realInvocation) => Future.value(0));
        when(mockCompareScreenRepo.getListOfHospitals())
            .thenAnswer((realInvocation) => Future.value(hospitalName));
        return compareScreenBloc;
      },
      act: (bloc) {
        bloc.add(CompareScreenListFetchHospitalName());
        bloc.add(CompareScreenListCompareButtonError("Add two hospitals"));
      },
      expect: [
        CompareScreenListLoadingState(),
        CompareScreenListLoadedState(hospitalName),
        CompareScreenListErrorState("Add two hospitals"),
        CompareScreenListLoadedState(hospitalName)
      ],
    );
  });
}
