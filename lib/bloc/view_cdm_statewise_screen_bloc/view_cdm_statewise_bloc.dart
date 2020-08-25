import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cost_of_care/repository/view_cdm_statewise_repository_impl.dart';

import './bloc.dart';

class ViewCdmStatewiseBloc
    extends Bloc<ViewCdmStatewiseEvent, ViewCdmStatewiseState> {
  ViewCdmStatewiseBloc(this.viewCDMStatewiseRepositoryImpl)
      : super(ViewCDMStatewiseLoadingState());

  ViewCDMStatewiseRepositoryImpl viewCDMStatewiseRepositoryImpl;

  ViewCdmStatewiseState get initialState => ViewCDMStatewiseLoadingState();

  @override
  Stream<ViewCdmStatewiseState> mapEventToState(
    ViewCdmStatewiseEvent event,
  ) async* {
    if (event is ViewCDMStatewiseFetchStates) {
      yield ViewCDMStatewiseLoadingState();
      //Check if already saved
      if (viewCDMStatewiseRepositoryImpl.checkSavedData()) {
        List<String> states =
            await viewCDMStatewiseRepositoryImpl.getSavedData();
        yield ViewCDMStatewiseLoadedState(states);
      }
      //Fetch Data
      else {
        try {
          List<String> states =
              await viewCDMStatewiseRepositoryImpl.getListOfStates();
          yield ViewCDMStatewiseLoadedState(states);
          viewCDMStatewiseRepositoryImpl.saveData(states);
        } catch (e) {
          yield ViewCDMStatewiseErrorState(e.message);
        }
      }
    }
  }
}
