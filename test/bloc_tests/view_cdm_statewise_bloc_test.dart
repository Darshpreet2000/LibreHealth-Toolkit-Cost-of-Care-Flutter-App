import 'package:bloc_test/bloc_test.dart';
import 'package:cost_of_care/bloc/view_cdm_statewise_screen_bloc/bloc.dart';
import 'package:cost_of_care/repository/view_cdm_statewise_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockViewCDMStatewiseScreenRepository extends Mock
    implements ViewCDMStatewiseRepositoryImpl {}

void main() {
  ViewCdmStatewiseBloc viewCDMStatewiseBloc;
  MockViewCDMStatewiseScreenRepository viewCDMStatewiseRepo;

  setUp(() {
    viewCDMStatewiseRepo = MockViewCDMStatewiseScreenRepository();
    viewCDMStatewiseBloc = ViewCdmStatewiseBloc(viewCDMStatewiseRepo);
  });
  tearDown(() {
    viewCDMStatewiseBloc?.close();
  });

  test('initial state is correct', () {
    expect(viewCDMStatewiseBloc.initialState, ViewCDMStatewiseLoadingState());
  });
  group('ViewCdmStatewiseBloc test', () {
    List<String> states = new List(1);

    blocTest(
      'emits [ViewCDMStatewiseLoadingState(),ViewCDMStatewiseLoadedState(states)] when ViewCDMStatewiseFetchStates is added',
      build: () {
        when(viewCDMStatewiseRepo.checkSavedData())
            .thenAnswer((realInvocation) => false);
        when(viewCDMStatewiseRepo.getListOfStates())
            .thenAnswer((realInvocation) => Future.value(states));
        return viewCDMStatewiseBloc;
      },
      act: (bloc) => bloc.add(ViewCDMStatewiseFetchStates()),
      expect: [
        ViewCDMStatewiseLoadingState(),
        ViewCDMStatewiseLoadedState(states)
      ],
    );

    blocTest(
      'emits [ViewCDMStatewiseLoadingState(),ViewCDMStatewiseErrorState()] when ViewCDMStatewiseFetchStates is added',
      build: () {
        when(viewCDMStatewiseRepo.checkSavedData())
            .thenAnswer((realInvocation) => false);
        when(viewCDMStatewiseRepo.getListOfStates())
            .thenThrow(Exception("Network Error!"));
        return viewCDMStatewiseBloc;
      },
      act: (bloc) => bloc.add(ViewCDMStatewiseFetchStates()),
      expect: [
        ViewCDMStatewiseLoadingState(),
        ViewCDMStatewiseErrorState("Network Error!")
      ],
    );
  });
}
