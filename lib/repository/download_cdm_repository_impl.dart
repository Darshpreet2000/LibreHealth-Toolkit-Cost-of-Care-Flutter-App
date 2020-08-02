import 'dart:io';

import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:curativecare/models/download_cdm_model.dart';
import 'package:curativecare/models/search_model.dart';
import 'package:curativecare/network/gitlab_api_client.dart';
import 'package:curativecare/repository/abstract/download_cdm_repository.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';
import 'database_repository_impl.dart';

class DownloadCDMRepositoryImpl extends DownloadCDMRepository {
  @override
  Future fetchData(String stateName) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
    Future responseBody = gitLabApiClient.getAvailableCdm(stateName);
    return responseBody;
  }

  Future parseData(List<dynamic> responseBody) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
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
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
      try {
        return await gitLabApiClient.downloadCSVFile(event);
      } catch (e) {
        event.downloadFileButtonBloc.add(DownloadFileButtonError(e.message));
        return;
      }
  }


  Future getFileSize(DownloadFileButtonClick event) async {
    double fileSize;
    GitLabApiClient gitLabApiClient = new GitLabApiClient();

    try {
      fileSize = await gitLabApiClient.getCSVFileSize(event);
    } catch (e) {
      event.downloadFileButtonBloc.add(DownloadFileButtonError(e.message));
      return;
    }
    return fileSize;
  }
  Future insertInDatabase(InsertInDatabase event) async {
    DatabaseRepositoryImpl databaseRepositoryImpl =
        new DatabaseRepositoryImpl();


    List<SearchModel> myList = new List();
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
//Clearing Cache
    DefaultCacheManager().emptyCache();
  return await databaseRepositoryImpl.insertCDM(event, myList);
  }
}
