part of 'refresh_saved_cdm_bloc.dart';

abstract class RefreshSavedCdmEvent extends Equatable {
  const RefreshSavedCdmEvent();
}

class RefreshCDMEventStart extends RefreshSavedCdmEvent {
  @override
  List<Object> get props => [];
}

class RefreshCDMEventCompleted extends RefreshSavedCdmEvent {
  @override
  List<Object> get props => [];
}

class RefreshCDMEventError extends RefreshSavedCdmEvent {
  final String message;

  RefreshCDMEventError(this.message);

  @override
  List<Object> get props => [message];
}
