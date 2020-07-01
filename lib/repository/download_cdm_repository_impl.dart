import 'package:curativecare/models/download_cdm_model.dart';
import 'package:curativecare/network/gitlab_api_client.dart';
import 'package:curativecare/repository/abstract/download_cdm_repository.dart';
import '../main.dart';

class DownloadCDMRepositoryImpl extends DownloadCDMRepository {
  @override
  Future fetchData(String stateName) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
    Future responseBody = gitLabApiClient.getAvailableCdm(stateName);
    return responseBody;
  }

  Future parseData(String responseBody) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
    List<DownloadCdmModel> hospitalsName =
        await gitLabApiClient.parseAvailableCdm(responseBody);
    return hospitalsName;
  }

  @override
  void saveData(List<DownloadCdmModel> hospitalsName) {
    String state = box.get('state');
    listbox.put('downloadCDMList$state', hospitalsName);
  }

  Future<bool> checkDataSaved() async {
    String state = await box.get('state');
    bool condition = listbox.containsKey('downloadCDMList$state');
    return condition;
  }

  Future<List<DownloadCdmModel>> getSavedData() async {
    String state = await box.get('state');
    List<DownloadCdmModel> data =
        await listbox.get('downloadCDMList$state').cast<DownloadCdmModel>();
    return data;
  }

  Future getCSVFile(DownloadCdmModel hospitalName, String stateName, int index,
      List<DownloadCdmModel> hospitals) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
    DownloadCdmModel downloadCdmModel =
        await gitLabApiClient.getCSVFile(hospitalName, stateName);

    return downloadCdmModel;
  }
}
