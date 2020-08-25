import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cost_of_care/models/search_model.dart';
import 'package:cost_of_care/repository/view_cdm_screen_repository_impl.dart';

import './bloc.dart';

class ViewCdmScreenBloc extends Bloc<ViewCdmScreenEvent, ViewCdmScreenState> {
  ViewCDMScreenRepositoryImpl viewCDMScreenRepositoryImpl;

  ViewCdmScreenBloc(this.viewCDMScreenRepositoryImpl)
      : super(LoadingViewCdmScreenState());

  ViewCdmScreenState get initialState => LoadingViewCdmScreenState();

  @override
  Stream<ViewCdmScreenState> mapEventToState(
    ViewCdmScreenEvent event,
  ) async* {
    if (event is LoadCdm) {
      yield LoadingViewCdmScreenState();
      try {
        List<SearchModel> cdmList =
            await viewCDMScreenRepositoryImpl.fetchCDMList(event.tableName);
        yield LoadedViewCdmScreenState(cdmList);
      } catch (e) {
        yield ErrorViewCdmScreenState(e.message);
      }
    }
  }
}
