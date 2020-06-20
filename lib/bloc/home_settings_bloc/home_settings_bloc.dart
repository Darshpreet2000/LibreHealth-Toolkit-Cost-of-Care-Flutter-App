import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class HomeSettingsBloc extends Bloc<HomeSettingsEvent, HomeSettingsState> {
  @override
  HomeSettingsState get initialState => LoadedState();

  @override
  Stream<HomeSettingsState> mapEventToState(
    HomeSettingsEvent event,
  ) async* {
    yield LoadedState();

    if (event is SaveSettings) {}
  }
}
