import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:curativecare/repository/download_cdm_repository_impl.dart';

import './bloc.dart';

class DownloadCdmBloc extends Bloc<DownloadCdmEvent, DownloadCdmState> {
  @override
  DownloadCdmState get initialState => LoadingState();
  DownloadCDMRepositoryImpl downloadCDMRepositoryImpl;

  DownloadCdmBloc(this.downloadCDMRepositoryImpl);

  @override
  Stream<DownloadCdmState> mapEventToState(
    DownloadCdmEvent event,
  ) async* {
    if (event is DownloadCDMFetchData) {
      yield LoadingState();
      List<String> hospitalsName =
          await downloadCDMRepositoryImpl.fetchData(event.stateName);
      yield LoadedState(hospitalsName);
      downloadCDMRepositoryImpl.saveData(hospitalsName);
    }
    else if (event is DownloadCDMError){
      yield ErrorState();
    }
  }
}
