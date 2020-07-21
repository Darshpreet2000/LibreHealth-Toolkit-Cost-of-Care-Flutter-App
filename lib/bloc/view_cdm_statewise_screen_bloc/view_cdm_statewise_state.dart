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
  List<String> states;

  ViewCDMStatewiseLoadedState(this.states);

  @override
  List<Object> get props => [states];
}
