import 'package:curativecare/models/home_settings_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeSettingsState extends Equatable {
  HomeSettingsModel homeSettingsModel;

  HomeSettingsState(this.homeSettingsModel);
}

class LoadedState extends HomeSettingsState {
  HomeSettingsModel homeSettingsModel;


  LoadedState(this.homeSettingsModel) : super(homeSettingsModel);

  @override
  List<Object> get props => [homeSettingsModel];
}

class LoadingState extends HomeSettingsState {
  HomeSettingsModel homeSettingsModel;


  LoadingState(this.homeSettingsModel) : super(homeSettingsModel);
  @override
  List<Object> get props => [homeSettingsModel];
}
