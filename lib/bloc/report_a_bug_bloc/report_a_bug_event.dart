part of 'report_a_bug_bloc.dart';

abstract class ReportABugEvent {
  const ReportABugEvent();
}

class ShowErrorSnackBarEvent extends ReportABugEvent {
  final String message;

  ShowErrorSnackBarEvent(this.message);
}
