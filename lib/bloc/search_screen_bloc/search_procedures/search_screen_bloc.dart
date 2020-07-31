import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:curativecare/models/search_model.dart';
import 'package:curativecare/repository/search_screen_repository_impl.dart';

import 'bloc.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  SearchScreenRepositoryImpl searchScreenRepositoryImpl;

  SearchScreenBloc(this.searchScreenRepositoryImpl) : super(InitialSearchScreenState());


  @override
  Stream<SearchScreenState> mapEventToState(
    SearchScreenEvent event,
  ) async* {
    if (event is SearchInDatabase) {
      yield SearchScreenLoadingState();
      List<SearchModel> resultList = await searchScreenRepositoryImpl
          .searchForProcedure(event.searchString);
      if (resultList.length == 0)
        yield SearchScreenNoDataState();
      else
        yield SearchScreenLoadedState(resultList);
    }
    else if(event is SearchInDatabaseFromViewCDMScreen){
      yield SearchScreenLoadingState();
      List<SearchModel> resultList = await searchScreenRepositoryImpl.searchForProcedureByHospitalName(event.searchString, event.hospitalName);
      if (resultList.length == 0)
        yield SearchScreenNoDataState();
      else
        yield SearchScreenLoadedState(resultList);

    }
  }
}
