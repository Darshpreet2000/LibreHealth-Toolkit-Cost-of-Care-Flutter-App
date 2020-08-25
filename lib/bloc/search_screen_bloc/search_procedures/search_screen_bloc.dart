import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cost_of_care/models/search_model.dart';
import 'package:cost_of_care/repository/search_screen_repository_impl.dart';

import 'bloc.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  SearchScreenRepositoryImpl searchScreenRepositoryImpl;

  SearchScreenBloc(this.searchScreenRepositoryImpl)
      : super(InitialSearchScreenState());

  SearchScreenState get initialState => InitialSearchScreenState();

  @override
  Stream<SearchScreenState> mapEventToState(
    SearchScreenEvent event,
  ) async* {
    if (event is SearchInDatabase) {
      yield SearchScreenLoadingState();
      try {
        List<SearchModel> resultList = await searchScreenRepositoryImpl
            .searchForProcedure(event.searchString);
        if (resultList.length == 0)
          yield SearchScreenNoDataState();
        else
          yield SearchScreenLoadedState(resultList);
      } on FormatException {
        yield SearchScreenFormatExceptionState(
            "Please enter a valid number to search by price");
      }
    } else if (event is SearchInDatabaseFromViewCDMScreen) {
      yield SearchScreenLoadingState();
      try {
        List<SearchModel> resultList =
            await searchScreenRepositoryImpl.searchForProcedureByHospitalName(
                event.searchString, event.hospitalName);
        if (resultList.length == 0)
          yield SearchScreenNoDataState();
        else
          yield SearchScreenLoadedState(resultList);
      } on FormatException {
        yield SearchScreenFormatExceptionState(
            "Please enter a valid number to search by price");
      }
    } else if (event is SearchScreenInitialStateEvent) {
      yield InitialSearchScreenState();
    }
  }
}
