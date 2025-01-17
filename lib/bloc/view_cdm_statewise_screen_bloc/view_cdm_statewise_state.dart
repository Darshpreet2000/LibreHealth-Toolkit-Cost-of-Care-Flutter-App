import 'package:equatable/equatable.dart';

abstract class ViewCdmStatewiseState extends Equatable {
  const ViewCdmStatewiseState();
}

class InitialViewCdmStatewiseState extends ViewCdmStatewiseState {
  @override
  List<Object> get props => [];
}

class ViewCDMStatewiseLoadingState extends ViewCdmStatewiseState {
  @override
  List<Object> get props => [];
}

class ViewCDMStatewiseLoadedState extends ViewCdmStatewiseState {
  final List<String> states;

  ViewCDMStatewiseLoadedState(this.states);

  @override
  List<Object> get props => [states];
}

class ViewCDMStatewiseErrorState extends ViewCdmStatewiseState {
  final String message;

  ViewCDMStatewiseErrorState(this.message);

  @override
  List<Object> get props => [message];
}
