import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:curativecare/models/home_settings_model.dart';
import 'package:curativecare/repository/home_settings_repository_impl.dart';

import './bloc.dart';

class HomeSettingsBloc extends Bloc<HomeSettingsEvent, HomeSettingsState> {
  HomeSettingsRepository homeSettingsRepository;

  HomeSettingsBloc(this.homeSettingsRepository);

  @override
  HomeSettingsState get initialState =>
      LoadingState(HomeSettingsModel(5, 'Ascending', true));

  @override
  Stream<HomeSettingsState> mapEventToState(
    HomeSettingsEvent event,
  ) async* {
    if (event is GetInitialSettings) {
      HomeSettingsModel homeSettingsModel =
          homeSettingsRepository.getInitialSettings();
      yield LoadedState(homeSettingsModel);
    }
    if (event is SaveSettings) {
      yield LoadingState(event.homeSettingsModel);
      await homeSettingsRepository.changeSettings(event.homeSettingsModel);
      yield LoadedState(event.homeSettingsModel);
    } else if (event is ToggleOrder) {
      event.homeSettingsModel.order == 'Ascending'
          ? event.homeSettingsModel.order = 'Descending'
          : event.homeSettingsModel.order = 'Ascending';
      yield LoadedState(event.homeSettingsModel);
    } else if (event is ChangeRadius) {
      yield LoadedState(event.homeSettingsModel);
    }
  }
}
