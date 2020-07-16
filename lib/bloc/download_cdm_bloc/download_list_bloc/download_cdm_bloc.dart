import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:curativecare/models/download_cdm_model.dart';
import 'package:curativecare/repository/download_cdm_repository_impl.dart';

import 'bloc.dart';

class DownloadCdmBloc extends Bloc<DownloadCdmEvent, DownloadCdmState> {
  @override
  DownloadCdmState get initialState => LoadingState();
  DownloadCDMRepositoryImpl downloadCDMRepositoryImpl;

  DownloadCdmBloc(this.downloadCDMRepositoryImpl);

  List<DownloadCdmModel> hospitals = new List();

  @override
  Stream<DownloadCdmState> mapEventToState(
    DownloadCdmEvent event,
  ) async* {
    if (event is DownloadCDMFetchData) {
      yield LoadingState();
      if (await downloadCDMRepositoryImpl.checkDataSaved()) {
        hospitals = await downloadCDMRepositoryImpl.getSavedData();
        yield LoadedState(hospitals);
      } else {
        String response =
            await downloadCDMRepositoryImpl.fetchData(event.stateName);
        if (response == "Network Problem" ||
            response == "CDMs Not Avaialable For Your Location") {
          yield ErrorState(response);
        } else {
          hospitals = await downloadCDMRepositoryImpl.parseData(response);
          yield LoadedState(hospitals);
          downloadCDMRepositoryImpl.saveData(hospitals);
        }
      }
    } else if (event is DownloadCDMRefreshList) {
      hospitals[event.index].isDownload = 1;
      downloadCDMRepositoryImpl.saveData(hospitals);
      yield (LoadedState(hospitals));
    } else if (event is DownloadCDMError) {
      yield ErrorState("Network Problem! Try Again");
    }
  }
}
