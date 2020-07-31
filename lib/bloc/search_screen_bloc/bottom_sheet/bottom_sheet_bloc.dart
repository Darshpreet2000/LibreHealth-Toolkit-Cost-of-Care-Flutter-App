import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:curativecare/repository/search_screen_repository_impl.dart';

import './bloc.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  SearchScreenRepositoryImpl searchScreenRepositoryImpl;

  BottomSheetBloc(this.searchScreenRepositoryImpl);

  @override
  BottomSheetState get initialState => BottomSheetLoadValues(0, 0);

  @override
  Stream<BottomSheetState> mapEventToState(
    BottomSheetEvent event,
  ) async* {
    if (event is BottomSheetFetchValues) {
      List<int> values = searchScreenRepositoryImpl.FetchValuesFromHive();
      yield BottomSheetLoadValues(values[0], values[1]);
    } else if (event is BottomSheetApply) {
      searchScreenRepositoryImpl.SaveValuesToHive(
          event.selectedRadioTile, event.priceRadioTile);
      yield BottomSheetSaved(event.selectedRadioTile, event.priceRadioTile);
    } else if (event is BottomSheetChangeValue) {
      yield BottomSheetLoadValues(
          event.selectedRadioTile, event.priceRadioTile);
    }
  }
}
