import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:curativecare/repository/compare_screen_repository_impl.dart';
import './bloc.dart';
import 'compare_screen_list_event.dart';
import 'compare_screen_list_state.dart';

class CompareScreenListBloc
    extends Bloc<CompareScreenListEvent, CompareScreenListState> {
  @override
  CompareScreenListState get initialState => CompareScreenListLoadingState();
  CompareScreenRepositoryImpl compareScreenRepositoryImpl;

  CompareScreenListBloc(this.compareScreenRepositoryImpl);

  @override
  Stream<CompareScreenListState> mapEventToState(
    CompareScreenListEvent event,
  ) async* {
    if (event is CompareScreenListFetchHospitalName) {
      try {
        List<CompareHospitalModel> hospitalName =
            await compareScreenRepositoryImpl.getListOfHospitals();
        yield CompareScreenListLoadedState(hospitalName);
      } catch (e) {
        yield CompareScreenListErrorState(e.message);
      }
    }
  }
}
