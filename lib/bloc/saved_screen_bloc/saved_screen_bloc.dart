import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:curativecare/repository/saved_screen_repository_impl.dart';

import './bloc.dart';

class SavedScreenBloc extends Bloc<SavedScreenEvent, SavedScreenState> {
  SavedScreenRepoImpl savedScreenRepoImpl;

  SavedScreenBloc(this.savedScreenRepoImpl);

  @override
  SavedScreenState get initialState => SavedScreenLoadingState();

  @override
  Stream<SavedScreenState> mapEventToState(
    SavedScreenEvent event,
  ) async* {
    if (event is LoadSavedData) {
      yield SavedScreenLoadingState();
      List<String> hospitalNames = await savedScreenRepoImpl.getAllTables();
      if (hospitalNames.length > 0) {
        yield SavedScreenLoadedState(hospitalNames);
      } else {
        yield SavedScreenErrorState("No Saved Data Found");
      }
    }
    else if (event is ShowNoDataFound){
      yield SavedScreenErrorState("No Saved Data Found");
    }
  }
}
