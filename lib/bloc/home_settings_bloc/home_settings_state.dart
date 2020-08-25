import 'package:cost_of_care/models/home_settings_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeSettingsState extends Equatable {}

class HomeSettingsLoadedState extends HomeSettingsState {
  final HomeSettingsModel homeSettingsModel;

  HomeSettingsLoadedState(this.homeSettingsModel);

  @override
  List<Object> get props => [
        homeSettingsModel.order,
        homeSettingsModel.radius,
        homeSettingsModel.isSelected,
        homeSettingsModel.latitude,
        homeSettingsModel.longitude,
        homeSettingsModel.address,
      ];
}

class HomeSettingsLoadingState extends HomeSettingsState {
  @override
  List<Object> get props => [];

  HomeSettingsLoadingState();
}
