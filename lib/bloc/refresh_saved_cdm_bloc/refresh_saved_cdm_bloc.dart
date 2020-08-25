import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'refresh_saved_cdm_event.dart';
part 'refresh_saved_cdm_state.dart';

class RefreshSavedCdmBloc
    extends Bloc<RefreshSavedCdmEvent, RefreshSavedCdmState> {
  RefreshSavedCdmBloc() : super(RefreshSavedCdmInitial());

  RefreshSavedCdmState get initialState => RefreshSavedCdmInitial();

  @override
  Stream<RefreshSavedCdmState> mapEventToState(
    RefreshSavedCdmEvent event,
  ) async* {
    if (event is RefreshCDMEventStart) {
      yield RefreshSavedCdmStart();
    } else if (event is RefreshCDMEventCompleted) {
      yield RefreshSavedCdmCompleted();
    } else if (event is RefreshCDMEventError) {
      yield RefreshSavedCdmError(event.message);
    }
  }
}
