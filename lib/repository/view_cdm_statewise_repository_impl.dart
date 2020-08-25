import 'package:cost_of_care/network/gitlab_api_client.dart';
import 'package:dio/dio.dart';

import '../main.dart';
import 'abstract/view_cdm_statewise_repository.dart';

class ViewCDMStatewiseRepositoryImpl extends ViewCDMStatewiseRepository {
//need to be done
  BaseOptions options = new BaseOptions(
      connectTimeout: 15 * 1000, // 60 seconds
      receiveTimeout: 15 * 1000 // 60 seconds
      );

  @override
  Future getListOfStates() {
    GitLabApiClient gitLabApiClient = new GitLabApiClient(Dio(options));
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

  void saveData(List<String> statesName) {
    listbox.put('statesName', statesName);
    return;
  }
}
