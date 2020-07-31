import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:curativecare/repository/download_cdm_repository_impl.dart';

import './bloc.dart';

class DownloadFileButtonBloc
    extends Bloc<DownloadFileButtonEvent, DownloadFileButtonState> {
  @override
  DownloadFileButtonState get initialState => InitialDownloadFileButtonState();
  DownloadCDMRepositoryImpl downloadCDMRepositoryImpl;

  DownloadFileButtonBloc(this.downloadCDMRepositoryImpl);

  @override
  Stream<DownloadFileButtonState> mapEventToState(
      DownloadFileButtonEvent event,
      ) async* {
    if (event is DownloadFileButtonClick) {
      //Show circular progress initially
      yield DownloadButtonLoadingCircular(event.index);
      downloadCDMRepositoryImpl.downloadCDM(event);
    } else if (event is DownloadFileButtonProgress) {
      yield DownloadButtonLoadingProgressIndicator(event.progress, event.index);
      if (event.progress == 0.6||(event.progress * 100).toStringAsFixed(0) == "60") {
        downloadCDMRepositoryImpl.insertInDatabase(event);
      } else if ((event.progress * 100).toStringAsFixed(0) == "100" ||
          (event.progress * 100) > 99) {
        yield DownloadButtonLoaded(event.index);
      }
    } else if (event is DownloadFileButtonError) {
      yield DownloadButtonErrorState(event.message);
    }
  }
}
