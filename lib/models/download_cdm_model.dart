import 'package:hive/hive.dart';
part 'download_cdm_model.g.dart';

@HiveType(typeId: 1)
class DownloadCdmModel {
  @HiveField(0)
  String hospitalName;
  @HiveField(1)
   int isDownload = 0;

//0 means not downloaded
  //1 means loading
  //2 means downloaded
  DownloadCdmModel(this.hospitalName, this.isDownload);

  DownloadCdmModel copyWith({String hospitalName, int isDownloaded}) {
    return DownloadCdmModel(this.hospitalName, this.isDownload);
  }

  @override
  String toString() {
    return 'Todo { complete: $isDownload, name: $hospitalName }';
  }
}
