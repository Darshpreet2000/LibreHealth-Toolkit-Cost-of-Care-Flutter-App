import 'package:equatable/equatable.dart';

abstract class HomeSettingsEvent extends Equatable {
  const HomeSettingsEvent();
}

class SaveSettings extends HomeSettingsEvent {
  @override
  List<Object> get props => [];
}
