import 'package:equatable/equatable.dart';

abstract class DownloadFileButtonState extends Equatable {
  const DownloadFileButtonState();
}

class InitialDownloadFileButtonState extends DownloadFileButtonState {
  @override
  List<Object> get props => [];
}

class DownloadButtonLoadingProgressIndicator extends DownloadFileButtonState {
  double progress;
  int index;

  DownloadButtonLoadingProgressIndicator(this.progress, this.index);

  @override
  List<Object> get props => [progress, index];
}

class DownloadButtonLoadingCircular extends DownloadFileButtonState {
  int index;

  DownloadButtonLoadingCircular(this.index);

  @override
  List<Object> get props => [index];
}

class DownloadButtonLoaded extends DownloadFileButtonState {
  int index;

  DownloadButtonLoaded(this.index);

  @override
  List<Object> get props => [index];
}

class DownloadButtonErrorState extends DownloadFileButtonState {
  String message;

  DownloadButtonErrorState(this.message);

  @override
  List<Object> get props => [message];
}
