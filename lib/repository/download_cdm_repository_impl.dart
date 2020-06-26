import 'package:curativecare/models/download_cdm_model.dart';
import 'package:curativecare/network/gitlab_api_client.dart';
import 'package:curativecare/repository/abstract/download_cdm_repository.dart';
import '../main.dart';

class DownloadCDMRepositoryImpl extends DownloadCDMRepository {
  @override
  Future fetchData(String stateName) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
    Future responseBody = gitLabApiClient.getAvailableCdm(stateName);
    List<DownloadCdmModel> hospitalsName =
        await gitLabApiClient.parseAvailableCdm(responseBody);
    return hospitalsName;
  }

  @override
  void saveData(List<DownloadCdmModel> hospitalsName) {
//    listbox.put('downloadCDMList', hospitalsName);
  }

  Future getCSVFile(DownloadCdmModel hospitalName, String stateName, int index,
      List<DownloadCdmModel> hospitals) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
    DownloadCdmModel downloadCdmModel =
        await gitLabApiClient.getCSVFile(hospitalName, stateName);

    return downloadCdmModel;
  }
}
