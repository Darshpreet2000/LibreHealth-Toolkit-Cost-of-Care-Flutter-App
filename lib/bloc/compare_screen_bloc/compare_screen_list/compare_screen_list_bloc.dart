import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cost_of_care/models/compare_hospital_model.dart';
import 'package:cost_of_care/repository/compare_screen_repository_impl.dart';

import './bloc.dart';
import 'compare_screen_list_event.dart';
import 'compare_screen_list_state.dart';

class CompareScreenListBloc
    extends Bloc<CompareScreenListEvent, CompareScreenListState> {
  CompareScreenRepositoryImpl compareScreenRepositoryImpl;
  int hospitalsAddedToCompare = 0;

  CompareScreenListBloc(this.compareScreenRepositoryImpl)
      : super(CompareScreenListLoadingState());

  CompareScreenListState get initialState => CompareScreenListLoadingState();

  @override
  Stream<CompareScreenListState> mapEventToState(
    CompareScreenListEvent event,
  ) async* {
    if (event is CompareScreenListFetchHospitalName) {
      yield CompareScreenListLoadingState();
      hospitalsAddedToCompare = 0;
      //check if list exists
      if (await compareScreenRepositoryImpl.checkSavedList()) {
        List<CompareHospitalModel> hospitalName =
            await compareScreenRepositoryImpl.fetchSavedList();
        yield CompareScreenListLoadedState(hospitalName);
      }
      //otherwise fetch from internet
      else {
        try {
          List<CompareHospitalModel> hospitalName =
              await compareScreenRepositoryImpl.getListOfHospitals();
          yield CompareScreenListLoadedState(hospitalName);
          compareScreenRepositoryImpl.saveList(hospitalName);
        } catch (e) {
          yield CompareScreenListErrorState(e.message);
        }
      }
    } else if (event is CompareScreenListCompareButtonEvent) {
      if (hospitalsAddedToCompare == 2 && event.isAddedForCompare) {
        List<CompareHospitalModel> hospitalList =
            (state as CompareScreenListLoadedState).hospitalName;
        yield CompareScreenListErrorState(
            "Cannot compare more than two hospitals");
        yield CompareScreenListLoadedState(hospitalList);
      } else {
        List<CompareHospitalModel> updatedList = new List();
        (state as CompareScreenListLoadedState).hospitalName.forEach((element) {
          updatedList.add(element.copyWith());
        });
        if (event.isAddedForCompare)
          hospitalsAddedToCompare++;
        else
          hospitalsAddedToCompare--;
        updatedList[event.index].isAddedToCompare = event.isAddedForCompare;
        yield CompareScreenListLoadedState(updatedList);
      }
    } else if (event is CompareScreenListCompareButtonError) {
      List<CompareHospitalModel> hospitalList =
          (state as CompareScreenListLoadedState).hospitalName;
      yield CompareScreenListErrorState(event.message);
      yield CompareScreenListLoadedState(hospitalList);
    }
  }
}
