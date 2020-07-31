import 'package:equatable/equatable.dart';

abstract class ViewCdmStatewiseEvent extends Equatable {
  const ViewCdmStatewiseEvent();
}

class ViewCDMStatewiseFetchStates extends ViewCdmStatewiseEvent {
  @override
  List<Object> get props => [];
}

class ViewCDMStatewiseFetchCDM extends ViewCdmStatewiseEvent {
  @override
  List<Object> get props => [];
}
