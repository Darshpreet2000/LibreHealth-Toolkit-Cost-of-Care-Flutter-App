import 'package:curativecare/network/gitlab_api_client.dart';
import 'package:curativecare/repository/abstract/download_cdm_repository.dart';

import '../main.dart';

class DownloadCDMRepositoryImpl extends DownloadCDMRepository {
  @override
  Future fetchData(String stateName) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
    Future responseBody = gitLabApiClient.getAvailableCdm(stateName);
    List<String> hospitalsName =
        await gitLabApiClient.parseAvailableCdm(responseBody);
    return hospitalsName;
  }

  @override
  void saveData(List<String> hospitalsName) {
    listbox.put('downloadCDMList', hospitalsName);
  }
  void  getCSVFile(String hospitalName,String stateName){
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
    gitLabApiClient.getCSVFile(hospitalName, stateName);
  }
}
