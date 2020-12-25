import 'package:bloc_test/bloc_test.dart';
import 'package:cost_of_care/bloc/view_cdm_screen_bloc/bloc.dart';
import 'package:cost_of_care/models/search_model.dart';
import 'package:cost_of_care/repository/view_cdm_screen_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockViewCDMScreenRepository extends Mock
    implements ViewCDMScreenRepositoryImpl {}

void main() {
  ViewCdmScreenBloc viewCDMScreenBloc;
  MockViewCDMScreenRepository mockViewCDMScreenRepo;
  setUp(() {
    mockViewCDMScreenRepo = MockViewCDMScreenRepository();
    viewCDMScreenBloc = ViewCdmScreenBloc(mockViewCDMScreenRepo);
  });
  tearDown(() {
    viewCDMScreenBloc?.close();
  });

  test('initial state is correct', () {
    expect(viewCDMScreenBloc.initialState, LoadingViewCdmScreenState());
  });
  group('Bloc test', () {
    List<SearchModel> cdmList =[];

    blocTest(
      'emits [LoadingViewCdmScreenState(), LoadedViewCdmScreenState] when LoadCdm is added',
      build: () {
        when(mockViewCDMScreenRepo.fetchCDMList("Alaska_Regional_Hospital"))
            .thenAnswer((realInvocation) => Future.value(cdmList));
        return viewCDMScreenBloc;
      },
      act: (bloc) => bloc.add(LoadCdm("Alaska_Regional_Hospital")),
      expect: [LoadingViewCdmScreenState(), LoadedViewCdmScreenState(cdmList)],
    );
    blocTest(
      'emits [LoadingViewCdmScreenState(), LoadedViewCdmScreenState] when LoadCdm is added',
      build: () {
        when(mockViewCDMScreenRepo.fetchCDMList("Alaska_Regional_Hospital"))
            .thenThrow(Exception("Table not found"));
        return viewCDMScreenBloc;
      },
      act: (bloc) => bloc.add(LoadCdm("Alaska_Regional_Hospital")),
      expect: [
        LoadingViewCdmScreenState(),
        ErrorViewCdmScreenState("Table not found")
      ],
    );
  });
}
