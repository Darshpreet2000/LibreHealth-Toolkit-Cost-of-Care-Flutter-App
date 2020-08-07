import 'package:curativecare/network/gitlab_api_client.dart';

import '../main.dart';
import 'abstract/view_cdm_statewise_repository.dart';

class ViewCDMStatewiseRepositoryImpl extends ViewCDMStatewiseRepository {
  @override
  Future getListOfStates() {
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
    return gitLabApiClient.fetchStatesName();
  }

  bool checkSavedData() {
    bool condition = listbox.containsKey('statesName');
    return condition;
  }

  Future<List<String>> getSavedData() async {
    List<String> data = await listbox.get('statesName').cast<String>();
    return data;
  }

  Future saveData(List<String> statesName) {
    listbox.put('statesName', statesName);
  }
}
