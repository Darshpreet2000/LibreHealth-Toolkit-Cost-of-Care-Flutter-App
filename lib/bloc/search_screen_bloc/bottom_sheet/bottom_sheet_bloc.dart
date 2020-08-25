import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cost_of_care/repository/search_screen_repository_impl.dart';

import './bloc.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  SearchScreenRepositoryImpl searchScreenRepositoryImpl;

  BottomSheetBloc(this.searchScreenRepositoryImpl)
      : super(BottomSheetLoadValues(0, 0, false));

  @override
  Stream<BottomSheetState> mapEventToState(
    BottomSheetEvent event,
  ) async* {
    if (event is BottomSheetFetchValues) {
      List<int> values = searchScreenRepositoryImpl.fetchValuesFromHive();
      yield BottomSheetLoadValues(
          values[0], values[1], values[2] == 0 ? false : true);
    } else if (event is BottomSheetApply) {
      searchScreenRepositoryImpl.saveValuesToHive(event.selectedRadioTile,
          event.priceRadioTile, event.searchBy == false ? 0 : 1);
      yield BottomSheetApplyValues(
          event.selectedRadioTile, event.priceRadioTile, event.searchBy);
    } else if (event is BottomSheetChangeValue) {
      yield BottomSheetLoadValues(
          event.selectedRadioTile, event.priceRadioTile, event.searchBy);
    }
  }
}
