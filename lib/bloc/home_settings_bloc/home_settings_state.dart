import 'package:equatable/equatable.dart';

abstract class HomeSettingsState extends Equatable {
  const HomeSettingsState();
}

class LoadedState extends HomeSettingsState {
  @override
  List<Object> get props => [];
}

class LoadingState extends HomeSettingsState {
  @override
  List<Object> get props => [];
}
