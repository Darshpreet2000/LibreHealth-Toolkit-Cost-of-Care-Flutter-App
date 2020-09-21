import 'dart:async';

import 'package:bloc/bloc.dart';

part 'report_a_bug_event.dart';
part 'report_a_bug_state.dart';

class ReportABugBloc extends Bloc<ReportABugEvent, ReportABugState> {
  ReportABugBloc() : super(ReportABugInitial());

  @override
  Stream<ReportABugState> mapEventToState(
    ReportABugEvent event,
  ) async* {
    if (event is ShowErrorSnackBarEvent) {
      yield ReportABugShowSnackBarState(event.message);
    }
  }
}
