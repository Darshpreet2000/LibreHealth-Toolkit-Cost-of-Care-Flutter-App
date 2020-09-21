import 'package:bloc_test/bloc_test.dart';
import 'package:cost_of_care/bloc/search_screen_bloc/search_procedures/bloc.dart';
import 'package:cost_of_care/models/search_model.dart';
import 'package:cost_of_care/repository/search_screen_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSearchScreenRepository extends Mock
    implements SearchScreenRepositoryImpl {}

void main() {
  SearchScreenBloc searchScreenBloc;
  MockSearchScreenRepository searchScreenRepoImpl;

  setUp(() {
    searchScreenRepoImpl = MockSearchScreenRepository();
    searchScreenBloc = SearchScreenBloc(searchScreenRepoImpl);
  });
  tearDown(() {
    searchScreenBloc?.close();
  });

  test('initial state is correct', () {
    expect(searchScreenBloc.initialState, InitialSearchScreenState());
  });
  group('SearchScreenBloc test', () {
    List<SearchModel> searchResults = new List(1);
    blocTest(
      'emits [SearchScreenLoadingState(), SearchScreenLoadedState()] when SearchInDatabase is added',
      build: () {
        when(searchScreenRepoImpl.searchForProcedure(any))
            .thenAnswer((realInvocation) => Future.value(searchResults));
        return searchScreenBloc;
      },
      act: (bloc) => bloc.add(SearchInDatabase("")),
      expect: [
        SearchScreenLoadingState(),
        SearchScreenLoadedState(searchResults)
      ],
    );
    blocTest(
      'emits [SearchScreenLoadingState(), SearchScreenLoadedState()] when SearchInDatabase is added',
      build: () {
        when(searchScreenRepoImpl.searchForProcedureByHospitalName("", ""))
            .thenAnswer((realInvocation) => Future.value(searchResults));
        return searchScreenBloc;
      },
      act: (bloc) => bloc.add(SearchInDatabaseFromViewCDMScreen("", "")),
      expect: [
        SearchScreenLoadingState(),
        SearchScreenLoadedState(searchResults)
      ],
    );
  });
}
