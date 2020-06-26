import 'package:curativecare/models/download_cdm_model.dart';
import 'package:equatable/equatable.dart';

abstract class DownloadCdmEvent extends Equatable {
  const DownloadCdmEvent();
}

class DownloadCDMFetchData extends DownloadCdmEvent {
  String stateName;

  DownloadCDMFetchData(this.stateName);

  @override
  List<Object> get props => [stateName];
}

class DownloadCDMGetCSV extends DownloadCdmEvent {
  String stateName;

  DownloadCdmModel hospital;
  int index;

  DownloadCDMGetCSV(this.stateName, this.hospital, this.index);

  @override
  List<Object> get props => [hospital, stateName, index];
}

class DownloadCDMError extends DownloadCdmEvent {
  @override
  List<Object> get props => [];
}
