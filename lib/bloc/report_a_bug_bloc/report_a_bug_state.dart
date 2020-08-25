part of 'report_a_bug_bloc.dart';

abstract class ReportABugState {
  const ReportABugState();
}

class ReportABugInitial extends ReportABugState {}

class ReportABugShowSnackBarState extends ReportABugState {
  final String message;

  ReportABugShowSnackBarState(this.message);
}
