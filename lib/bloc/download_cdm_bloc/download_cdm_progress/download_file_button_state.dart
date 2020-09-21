import 'package:equatable/equatable.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

abstract class DownloadFileButtonState extends Equatable {
  const DownloadFileButtonState();
}

class InitialDownloadFileButtonState extends DownloadFileButtonState {
  @override
  List<Object> get props => [];
}

class DownloadButtonLoadingProgressIndicator extends DownloadFileButtonState {
  final double progress;
  final int index;

  DownloadButtonLoadingProgressIndicator(this.progress, this.index);

  @override
  List<Object> get props => [progress, index];
}

class DownloadButtonLoadingCircular extends DownloadFileButtonState {
  final int index;

  DownloadButtonLoadingCircular(this.index);

  @override
  List<Object> get props => [index];
}

class DownloadButtonLoaded extends DownloadFileButtonState {
  final int index;

  DownloadButtonLoaded(this.index);

  @override
  List<Object> get props => [index];
}

class DownloadButtonErrorState extends DownloadFileButtonState {
  final String message;

  DownloadButtonErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class DownloadButtonStream extends DownloadFileButtonState {
  final Stream<FileResponse> fileStream;
  final int index;
  final double fileSize;

  @override
  List<Object> get props => [fileStream, index, fileSize];

  DownloadButtonStream(this.fileStream, this.index, this.fileSize);
}
