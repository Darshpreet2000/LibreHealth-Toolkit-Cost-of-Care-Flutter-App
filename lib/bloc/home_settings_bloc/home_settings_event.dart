import 'package:cost_of_care/models/home_settings_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeSettingsEvent extends Equatable {
  const HomeSettingsEvent();
}

class GetInitialSettings extends HomeSettingsEvent {
  @override
  List<Object> get props => [];
}

class ToggleOrder extends HomeSettingsEvent {
  final HomeSettingsModel homeSettingsModel;

  ToggleOrder(this.homeSettingsModel);

  @override
  List<Object> get props => [homeSettingsModel];
}

class ChangeRadius extends HomeSettingsEvent {
  final HomeSettingsModel homeSettingsModel;

  ChangeRadius(this.homeSettingsModel);

  @override
  List<Object> get props => [homeSettingsModel];
}

class ChangeLocation extends HomeSettingsEvent {
  final HomeSettingsModel homeSettingsModel;

  ChangeLocation(this.homeSettingsModel);

  @override
  List<Object> get props => [homeSettingsModel];
}

class SaveSettings extends HomeSettingsEvent {
  final HomeSettingsModel homeSettingsModel;

  SaveSettings(this.homeSettingsModel);

  @override
  List<Object> get props => [homeSettingsModel];
}
