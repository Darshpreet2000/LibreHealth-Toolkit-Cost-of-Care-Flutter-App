import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:cost_of_care/models/download_cdm_model.dart';
import 'package:cost_of_care/models/search_model.dart';
import 'package:cost_of_care/network/gitlab_api_client.dart';
import 'package:cost_of_care/repository/abstract/download_cdm_repository.dart';
import 'package:dio/dio.dart';

import '../main.dart';
import 'database_repository_impl.dart';

class DownloadCDMRepositoryImpl extends DownloadCDMRepository {
//need to be done
  BaseOptions options = new BaseOptions(
      connectTimeout: 15 * 1000, // 60 seconds
      receiveTimeout: 15 * 1000 // 60 seconds
      );

  @override
  Future fetchData(String stateName) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient(Dio(options));
    Future responseBody = gitLabApiClient.getAvailableCdm(stateName);
    return responseBody;
  }

  Future parseData(List<dynamic> responseBody) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient(Dio(options));
    List<DownloadCdmModel> hospitalsName =
        await gitLabApiClient.parseAvailableCdm(responseBody);
    return hospitalsName;
  }

  @override
  void saveData(List<DownloadCdmModel> hospitalsName, String state) {
    listbox.put('downloadCDMList$state', hospitalsName);
  }

  Future<bool> checkDataSaved(String state) async {
    bool condition = listbox.containsKey('downloadCDMList$state');
    return condition;
  }

  Future<List<DownloadCdmModel>> getSavedData(String state) async {
    List<DownloadCdmModel> data =
        await listbox.get('downloadCDMList$state').cast<DownloadCdmModel>();
    return data;
  }

  Future downloadCDM(DownloadFileButtonClick event) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient(Dio(options));
    return await gitLabApiClient.downloadCSVFile(event);
  }

  Future getFileSize(DownloadFileButtonClick event) async {
    double fileSize;
    GitLabApiClient gitLabApiClient = new GitLabApiClient(Dio(options));
    fileSize = await gitLabApiClient.getCSVFileSize(event);
    return fileSize;
  }

  Future insertInDatabase(InsertInDatabase event) async {
    DatabaseRepositoryImpl databaseRepositoryImpl =
        new DatabaseRepositoryImpl();

    // Saving URL of hospital for refreshing CDM
    List<SearchModel> myList = [];
    List<String> lines = event.fileInfo.file.readAsLinesSync();
    lines.removeAt(0);
    for (int i = 0; i < lines.length; i++) {
      String description = "", category;
      double price;

      String line = lines[i];
      List<String> parts = line.split(',');
      category = parts[parts.length - 1];
      try {
        double priceDouble = double.parse(parts[parts.length - 2]);
        if (priceDouble is double) price = priceDouble;
      } catch (NumberFormatException) {
        price = 0.0;
      }
      for (int i = 0; i < parts.length - 2; i++) {
        if (i == parts.length - 3)
          description += parts[i];
        else
          description += parts[i] + ", ";
      }
      myList.add(new SearchModel(description, price, category));
    } // Skip the header row

    return await databaseRepositoryImpl.insertCDM(event, myList);
  }
}
