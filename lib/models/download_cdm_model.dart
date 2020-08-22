import 'package:hive/hive.dart';
part 'download_cdm_model.g.dart';

@HiveType(typeId: 1)
// ignore: must_be_immutable
class DownloadCdmModel {
  @HiveField(0)
  String hospitalName;
  @HiveField(1)
  int isDownload = 0;

  //0 means not downloaded
  //1 means downloaded
  DownloadCdmModel(this.hospitalName, this.isDownload);

  DownloadCdmModel copyWith({String hospitalName, int isDownloaded}) {
    return DownloadCdmModel(this.hospitalName, this.isDownload);
  }
}
