import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:curativecare/repository/view_cdm_statewise_repository_impl.dart';

import './bloc.dart';

class ViewCdmStatewiseBloc
    extends Bloc<ViewCdmStatewiseEvent, ViewCdmStatewiseState> {
  ViewCdmStatewiseBloc(this.viewCDMStatewiseRepositoryImpl);

  @override
  ViewCdmStatewiseState get initialState => InitialViewCdmStatewiseState();
  ViewCDMStatewiseRepositoryImpl viewCDMStatewiseRepositoryImpl;

  @override
  Stream<ViewCdmStatewiseState> mapEventToState(
    ViewCdmStatewiseEvent event,
  ) async* {
    if (event is ViewCDMStatewiseFetchStates) {
      yield ViewCDMStatewiseLoadingState();
      //Check if already saved
      if(viewCDMStatewiseRepositoryImpl.checkSavedData()){
        List<String> states  = await viewCDMStatewiseRepositoryImpl.getSavedData();
        yield ViewCDMStatewiseLoadedState(states);

      }
      //Fetch Data
      else {
        List<String> states =
        await viewCDMStatewiseRepositoryImpl.getListOfStates();
        yield ViewCDMStatewiseLoadedState(states);
        viewCDMStatewiseRepositoryImpl.saveData(states);
      }
      } else if (event is ViewCDMStatewiseFetchCDM) {
      yield ViewCDMStatewiseLoadingState();
      //Fetch Data
      List<String> states;
      yield ViewCDMStatewiseLoadedState(states);
    }
  }
}
