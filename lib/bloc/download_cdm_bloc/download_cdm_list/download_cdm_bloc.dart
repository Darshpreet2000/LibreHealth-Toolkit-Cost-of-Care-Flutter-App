import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cost_of_care/models/download_cdm_model.dart';
import 'package:cost_of_care/repository/download_cdm_repository_impl.dart';

import 'bloc.dart';

class DownloadCdmBloc extends Bloc<DownloadCdmEvent, DownloadCdmState> {
  DownloadCDMRepositoryImpl downloadCDMRepositoryImpl;

  DownloadCdmBloc(this.downloadCDMRepositoryImpl) : super(LoadingState());

  List<DownloadCdmModel> hospitals = [];

  DownloadCdmState get initialState => LoadingState();

  @override
  Stream<DownloadCdmState> mapEventToState(
    DownloadCdmEvent event,
  ) async* {
    if (event is DownloadCDMFetchData) {
      yield LoadingState();
      if (await downloadCDMRepositoryImpl.checkDataSaved(event.stateName)) {
        hospitals =
            await downloadCDMRepositoryImpl.getSavedData(event.stateName);
        yield LoadedState(hospitals);
      } else {
        try {
          List<dynamic> response =
              await downloadCDMRepositoryImpl.fetchData(event.stateName);
          hospitals = await downloadCDMRepositoryImpl.parseData(response);
          yield LoadedState(hospitals);
          downloadCDMRepositoryImpl.saveData(hospitals, event.stateName);
        } catch (e) {
          yield ErrorState(e.message);
        }
      }
    } else if (event is DownloadCDMRefreshList) {
      hospitals[event.index].isDownload = 1;
      downloadCDMRepositoryImpl.saveData(hospitals, event.stateName);
      yield RefreshedState(hospitals);
    } else if (event is DownloadCDMError) {
      yield ErrorState(event.message);
    }
  }
}
