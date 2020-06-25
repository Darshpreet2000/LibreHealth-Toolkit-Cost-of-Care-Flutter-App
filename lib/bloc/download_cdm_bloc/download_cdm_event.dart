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

class DownloadCDMGetCSV extends DownloadCdmEvent{
  String stateName,hospitalName;

  DownloadCDMGetCSV(this.stateName, this.hospitalName);

  @override
  List<Object> get props => [hospitalName,stateName];

}
class DownloadCDMError extends DownloadCdmEvent{
  @override
  List<Object> get props => [];

}