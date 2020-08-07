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

class DownloadCDMSaveList extends DownloadCdmEvent {
  int index;

  DownloadCDMSaveList(this.index);

  @override
  List<Object> get props => [index];
}

class DownloadCDMRefreshList extends DownloadCdmEvent {
  int index;
  String stateName;

  DownloadCDMRefreshList(this.index, this.stateName);

  @override
  List<Object> get props => [index, stateName];
}

class DownloadCDMError extends DownloadCdmEvent {
  @override
  List<Object> get props => [];
}
