import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:curativecare/repository/download_cdm_repository_impl.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import './bloc.dart';

class DownloadFileButtonBloc
    extends Bloc<DownloadFileButtonEvent, DownloadFileButtonState> {
  DownloadCDMRepositoryImpl downloadCDMRepositoryImpl;

  DownloadFileButtonBloc(this.downloadCDMRepositoryImpl)
      : super(InitialDownloadFileButtonState());
  DownloadFileButtonState get initialState => InitialDownloadFileButtonState();
  @override
  Stream<DownloadFileButtonState> mapEventToState(
    DownloadFileButtonEvent event,
  ) async* {
    if (event is DownloadFileButtonClick) {
      //Show circular progress initially
      yield DownloadButtonLoadingCircular(event.index);
      try {
        double fileSize = await downloadCDMRepositoryImpl.getFileSize(event);
        Stream<FileResponse> fileStream =
            await downloadCDMRepositoryImpl.downloadCDM(event);
        yield DownloadButtonStream(fileStream, event.index, fileSize);
      } catch (e) {
        event.downloadFileButtonBloc.add(DownloadFileButtonError(e.message));
        yield DownloadButtonErrorState(e.message);
      }
    } else if (event is DownloadFileButtonProgress) {
      yield DownloadButtonLoadingProgressIndicator(event.progress, event.index);
      if (event.progress * 100 > 99) {
        yield DownloadButtonLoaded(event.index);
      }
    } else if (event is InsertInDatabase) {
      downloadCDMRepositoryImpl.insertInDatabase(event);
    } else if (event is DownloadFileButtonError) {
      yield DownloadButtonErrorState(event.message);
    }
  }
}
