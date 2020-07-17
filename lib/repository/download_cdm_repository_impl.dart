import 'dart:io';

import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:curativecare/models/download_cdm_model.dart';
import 'package:curativecare/models/search_model.dart';
import 'package:curativecare/network/gitlab_api_client.dart';
import 'package:curativecare/repository/abstract/download_cdm_repository.dart';
import 'package:file_utils/file_utils.dart';
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

  Future downloadCDM(DownloadFileButtonClick event) async {
    GitLabApiClient gitLabApiClient = new GitLabApiClient();
    bool checkPermission = false;
    var status = await Permission.storage.status;
    if (status.isDenied || status.isUndetermined) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) checkPermission = true;
    if (checkPermission == true) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        dirloc = appDocDir.path;
      }
      FileUtils.mkdir([dirloc]);
      String stateName = box.get('state');
      String url =
          "https://gitlab.com/api/v4/projects/18885282/repository/files/CDM" +
              "%2F$stateName%2F${event.hospitalName}" +
              ".csv" +
              "?ref=branch-with-data";
      double fileSize;
      try {
        fileSize = await gitLabApiClient.getCSVFileSize(url, event);
      } catch (e) {
        event.downloadFileButtonBloc.add(DownloadFileButtonError(e.message));
        return;
      }
      String baseURL =
          "https://gitlab.com/Darshpreet2000/lh-toolkit-cost-of-care-app-data-scraper/-/raw/branch-with-data/CDM";
      url = baseURL + "/$stateName/${event.hospitalName}" + ".csv";
      try {
        await gitLabApiClient.downloadCSVFile(url, fileSize, event, dirloc);
      }
      catch (e) {
        event.downloadFileButtonBloc.add(DownloadFileButtonError(e.message));
        return;
      }
    } else {
      //Permission denied
      event.downloadFileButtonBloc
          .add(DownloadFileButtonError("Permission Denied"));
    }
  }

  Future insertInDatabase(DownloadFileButtonProgress event) async {
    DatabaseRepositoryImpl databaseRepositoryImpl =
        new DatabaseRepositoryImpl();
    String dirloc = "";
    if (Platform.isAndroid) {
      dirloc = "/sdcard/download/";
    } else {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      dirloc = appDocDir.path;
    }
    List<SearchModel> myList = new List();
    List<String> lines =
        File(dirloc + "${event.hospitalName}" + ".csv").readAsLinesSync();
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
    databaseRepositoryImpl.insertCDM(event, myList);
  }
}
