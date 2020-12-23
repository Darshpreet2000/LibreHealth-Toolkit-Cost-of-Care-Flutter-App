import 'package:bloc_test/bloc_test.dart';
import 'package:cost_of_care/bloc/saved_screen_bloc/bloc.dart';
import 'package:cost_of_care/models/download_cdm_model.dart';
import 'package:cost_of_care/repository/saved_screen_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSavedScreenRepository extends Mock implements SavedScreenRepoImpl {}

void main() {
  SavedScreenBloc savedScreenBloc;
  MockSavedScreenRepository savedScreenRepoImpl;

  setUp(() {
    savedScreenRepoImpl = MockSavedScreenRepository();
    savedScreenBloc = SavedScreenBloc(savedScreenRepoImpl);
  });
  tearDown(() {
    savedScreenBloc?.close();
  });

  test('initial state is correct', () {
    expect(savedScreenBloc.initialState, SavedScreenLoadingState());
  });
  group('SavedScreenBloc test', () {
    List<DownloadCdmModel> tableNames = [];
    tableNames.add(DownloadCdmModel("Alaska Regional Hospital", 1));
    blocTest(
      'emits [SavedScreenLoadingState(), SavedScreenLoadedState()] when LoadSavedData is added',
      build: () {
        when(savedScreenRepoImpl.getAllTables())
            .thenAnswer((realInvocation) => Future.value(tableNames));
        return savedScreenBloc;
      },
      act: (bloc) => bloc.add(LoadSavedData()),
      expect: [SavedScreenLoadingState(), SavedScreenLoadedState(tableNames)],
    );
    blocTest(
      'emits [SavedScreenLoadingState(), SavedScreenErrorState] when LoadSavedData is added',
      build: () {
        List<DownloadCdmModel> tableNames = [];
        when(savedScreenRepoImpl.getAllTables())
            .thenAnswer((realInvocation) => Future.value(tableNames));
        return savedScreenBloc;
      },
      act: (bloc) => bloc.add(LoadSavedData()),
      expect: [
        SavedScreenLoadingState(),
        SavedScreenErrorState("No Saved Data Found")
      ],
    );
    blocTest(
      'emits [SavedScreenErrorState] when LoadSavedData is added',
      build: () {
        List<DownloadCdmModel> tableNames = [];
        when(savedScreenRepoImpl.getAllTables())
            .thenAnswer((realInvocation) => Future.value(tableNames));
        return savedScreenBloc;
      },
      act: (bloc) => bloc.add(ShowNoDataFound()),
      expect: [SavedScreenErrorState("No Saved Data Found")],
    );
  });
}
