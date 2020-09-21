import 'package:equatable/equatable.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'download_file_button_bloc.dart';

abstract class DownloadFileButtonEvent extends Equatable {
  const DownloadFileButtonEvent();
}

class DownloadFileButtonClick extends DownloadFileButtonEvent {
  final int index;
  final String hospitalName;
  final String stateName;
  final DownloadFileButtonBloc downloadFileButtonBloc;

  DownloadFileButtonClick(this.index, this.hospitalName, this.stateName,
      this.downloadFileButtonBloc);

  @override
  List<Object> get props =>
      [index, hospitalName, stateName, downloadFileButtonBloc];
}

class DownloadFileButtonProgress extends DownloadFileButtonEvent {
  final double progress;
  final int index;
  final String hospitalName;
  final DownloadFileButtonBloc downloadFileButtonBloc;

  DownloadFileButtonProgress(this.progress, this.index, this.hospitalName,
      this.downloadFileButtonBloc);

  @override
  List<Object> get props => [progress, index];
}

class DownloadFileButtonError extends DownloadFileButtonEvent {
  final String message;

  DownloadFileButtonError(this.message);

  @override
  List<Object> get props => [message];
}

class InsertInDatabase extends DownloadFileButtonEvent {
  final int index;
  final FileInfo fileInfo;
  final String hospitalName;
  final DownloadFileButtonBloc downloadFileButtonBloc;

  InsertInDatabase(this.index, this.fileInfo, this.hospitalName,
      this.downloadFileButtonBloc);

  @override
  List<Object> get props =>
      [index, fileInfo, hospitalName, downloadFileButtonBloc];
}
