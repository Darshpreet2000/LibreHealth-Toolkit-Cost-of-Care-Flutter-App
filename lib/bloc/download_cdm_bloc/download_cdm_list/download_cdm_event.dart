import 'package:equatable/equatable.dart';

abstract class DownloadCdmEvent extends Equatable {
  const DownloadCdmEvent();
}

class DownloadCDMFetchData extends DownloadCdmEvent {
  final String stateName;

  DownloadCDMFetchData(this.stateName);

  @override
  List<Object> get props => [stateName];
}

class DownloadCDMSaveList extends DownloadCdmEvent {
  final int index;

  DownloadCDMSaveList(this.index);

  @override
  List<Object> get props => [index];
}

class DownloadCDMRefreshList extends DownloadCdmEvent {
  final int index;
  final String stateName;

  DownloadCDMRefreshList(this.index, this.stateName);

  @override
  List<Object> get props => [index, stateName];
}

class DownloadCDMError extends DownloadCdmEvent {
  final String message;

  DownloadCDMError(this.message);

  @override
  List<Object> get props => [message];
}
