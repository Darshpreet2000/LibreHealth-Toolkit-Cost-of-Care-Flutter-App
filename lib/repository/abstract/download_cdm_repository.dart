import 'package:curativecare/models/download_cdm_model.dart';

abstract class DownloadCDMRepository {
  Future fetchData(String stateName);

  void saveData(List<DownloadCdmModel> hospitalsName, String stateName);
}
