import 'package:bloc_test/bloc_test.dart';
import 'package:curativecare/bloc/saved_screen_bloc/bloc.dart';
import 'package:curativecare/repository/saved_screen_repository_impl.dart';
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
    List<String> tableNames = new List();
    tableNames.add("Alaska Regional Hospital");
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
        List<String> tableNames = new List();
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
        List<String> tableNames = new List();
        when(savedScreenRepoImpl.getAllTables())
            .thenAnswer((realInvocation) => Future.value(tableNames));
        return savedScreenBloc;
      },
      act: (bloc) => bloc.add(ShowNoDataFound()),
      expect: [SavedScreenErrorState("No Saved Data Found")],
    );
  });
}
