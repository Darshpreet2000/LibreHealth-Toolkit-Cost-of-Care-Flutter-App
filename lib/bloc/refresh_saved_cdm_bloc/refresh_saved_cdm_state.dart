part of 'refresh_saved_cdm_bloc.dart';

abstract class RefreshSavedCdmState extends Equatable {
  const RefreshSavedCdmState();
}

class RefreshSavedCdmInitial extends RefreshSavedCdmState {
  @override
  List<Object> get props => [];
}

class RefreshSavedCdmStart extends RefreshSavedCdmState {
  @override
  List<Object> get props => [];
}

class RefreshSavedCdmCompleted extends RefreshSavedCdmState {
  @override
  List<Object> get props => [];
}

class RefreshSavedCdmRemovedAll extends RefreshSavedCdmState {
  final String message;

  RefreshSavedCdmRemovedAll(this.message);

  @override
  List<Object> get props => [message];
}

class RefreshSavedCdmError extends RefreshSavedCdmState {
  final String message;

  RefreshSavedCdmError(this.message);

  @override
  List<Object> get props => [message];
}
