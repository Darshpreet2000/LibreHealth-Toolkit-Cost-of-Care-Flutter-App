import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:curativecare/repository/compare_screen_repository_impl.dart';
import './bloc.dart';
import 'compare_screen_list_event.dart';
import 'compare_screen_list_state.dart';

class CompareScreenListBloc
    extends Bloc<CompareScreenListEvent, CompareScreenListState> {
  CompareScreenRepositoryImpl compareScreenRepositoryImpl;
  int hospitalsAddedToCompare = 0;

  CompareScreenListBloc(this.compareScreenRepositoryImpl)
      : super(CompareScreenListLoadingState());

  @override
  Stream<CompareScreenListState> mapEventToState(
    CompareScreenListEvent event,
  ) async* {
    if (event is CompareScreenListFetchHospitalName) {
      try {
        List<CompareHospitalModel> hospitalName = await compareScreenRepositoryImpl.getListOfHospitals();
        yield CompareScreenListLoadedState(hospitalName);
      } catch (e) {
        yield CompareScreenListErrorState(e.message);
      }
    } else if (event is CompareScreenListCompareButtonEvent) {
      if (hospitalsAddedToCompare == 2&&event.isAddedForCompare) {
        List<CompareHospitalModel> hospitalList=(state as CompareScreenListLoadedState).hospitalName;
        yield CompareScreenListErrorState(
            "Cannot compare more than two hospitals");
        yield CompareScreenListLoadedState(hospitalList);
      } else {
       List<CompareHospitalModel> updatedList=new List();
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
    }
  }
}
