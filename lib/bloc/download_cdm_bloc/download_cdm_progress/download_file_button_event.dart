import 'package:equatable/equatable.dart';

import 'download_file_button_bloc.dart';

abstract class DownloadFileButtonEvent extends Equatable {
  const DownloadFileButtonEvent();
}

class DownloadFileButtonClick extends DownloadFileButtonEvent {
  int index;
  String hospitalName;
  String stateName;
  final DownloadFileButtonBloc downloadFileButtonBloc;


  DownloadFileButtonClick(this.index, this.hospitalName, this.stateName,
      this.downloadFileButtonBloc);

  @override
  List<Object> get props => [index, hospitalName,stateName];
}

class DownloadFileButtonProgress extends DownloadFileButtonEvent {
  double progress;
  int index;
  String hospitalName;
  final DownloadFileButtonBloc downloadFileButtonBloc;

  DownloadFileButtonProgress(this.progress, this.index, this.hospitalName,
      this.downloadFileButtonBloc);

  @override
  List<Object> get props => [progress, index];
}

class DownloadFileButtonError extends DownloadFileButtonEvent {
  String message;

  DownloadFileButtonError(this.message);

  @override
  List<Object> get props => [message];
}
