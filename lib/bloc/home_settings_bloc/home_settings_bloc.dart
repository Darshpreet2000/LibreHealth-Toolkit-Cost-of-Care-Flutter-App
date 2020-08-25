import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cost_of_care/models/home_settings_model.dart';
import 'package:cost_of_care/repository/home_settings_repository_impl.dart';

import './bloc.dart';

class HomeSettingsBloc extends Bloc<HomeSettingsEvent, HomeSettingsState> {
  HomeSettingsRepoImpl homeSettingsRepository;

  HomeSettingsBloc(this.homeSettingsRepository)
      : super(HomeSettingsLoadingState());

  HomeSettingsState get initialState => HomeSettingsLoadingState();

  @override
  Stream<HomeSettingsState> mapEventToState(
    HomeSettingsEvent event,
  ) async* {
    if (event is GetInitialSettings) {
      HomeSettingsModel homeSettingsModel =
          homeSettingsRepository.getInitialSettings();
      yield HomeSettingsLoadedState(homeSettingsModel);
    }
    if (event is SaveSettings) {
      yield HomeSettingsLoadingState();
      await homeSettingsRepository.saveSettings(event.homeSettingsModel);
      yield HomeSettingsLoadedState(event.homeSettingsModel);
    } else if (event is ToggleOrder) {
      event.homeSettingsModel.order == 'Ascending'
          ? event.homeSettingsModel.order = 'Descending'
          : event.homeSettingsModel.order = 'Ascending';
      yield HomeSettingsLoadedState(event.homeSettingsModel);
    } else if (event is ChangeRadius) {
      yield HomeSettingsLoadedState(event.homeSettingsModel);
    } else if (event is ChangeLocation) {
      yield HomeSettingsLoadedState(event.homeSettingsModel);
    }
  }
}
