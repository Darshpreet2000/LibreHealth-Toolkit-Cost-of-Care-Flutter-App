import 'dart:convert';
import 'dart:io';

import 'package:curativecare/models/download_cdm_model.dart';
import 'package:curativecare/models/search_model.dart';
import 'package:curativecare/repository/database_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GitLabApiClient {
  String base_url =
      "https://gitlab.com/api/v4/projects/18885282/repository/tree?ref=scrap-cdm-of-Indiana&path=CDM/";

  Future getAvailableCdm(String stateName) async {
    String url = base_url + stateName + "&per_page=100&page=";
    int i = 1;

    http.Response response;
    try {
      response = await http.get(url + "1");
    } on SocketException {
      return "Network problem";
    }

    Map<String, String> headers = response.headers;
    String responseBody = response.body;
    if (responseBody.length == 2) {
      return "CDMs Not Avaialable For Your Location";
    }
    responseBody = responseBody.substring(
        responseBody.indexOf("[") + 1, responseBody.lastIndexOf("]"));
    String maxLen = headers["x-total-pages"];
    i++;
    while (i <= int.parse(maxLen)) {
      try {
        response = await http.get(url + i.toString());
      } on SocketException {
        return "Network problem";
      }
      String currentResponse = response.body;
      currentResponse = currentResponse.substring(
          currentResponse.indexOf("[") + 1, currentResponse.lastIndexOf("]"));
      responseBody += "," + currentResponse;
      i++;
    }

    return "[" + responseBody + "]";
  }

  Future<List<DownloadCdmModel>> parseAvailableCdm(String responseBody) async {
    var res = await responseBody;
    var elements = json.decode(res) as List;
    List<DownloadCdmModel> name = new List();
    for (int i = 0; i < elements.length; i++) {
      Map<String, dynamic> current_hospital = elements[i];
      String hospitalName = current_hospital['name'];
      hospitalName = hospitalName.substring(0, hospitalName.length - 4);
      name.add(DownloadCdmModel(hospitalName, 0));
    }
    return name;
  }

  Future getCSVFile(DownloadCdmModel hospital, String stateName) async {
    String baseURL =
        "https://gitlab.com/Darshpreet2000/lh-toolkit-cost-of-care-app-data-scraper/-/raw/scrap-cdm-of-Indiana/CDM";
    String url = baseURL + "/$stateName/${hospital.hospitalName}" + ".csv";
    Dio dio = Dio();
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

      try {
        FileUtils.mkdir([dirloc]);

        var response = await dio.download(
            url, dirloc + "${hospital.hospitalName}" + ".csv");
        if (response.statusCode == 200) {
          DatabaseRepositoryImpl databaseRepositoryImpl =
              new DatabaseRepositoryImpl();
          List<String> lines =
              new File(dirloc + "${hospital.hospitalName}" + ".csv")
                  .readAsLinesSync();
          bool isFirstLine = true;
          List<SearchModel> myList = new List();
          for (var line in lines) {
            bool first = false, second = false, third = false;
            String description, price, category;
            int lastindex = line.length;
            for (int i = line.length - 1; i >= 0; i--) {
              if (second == true && third == true) {
                description = line.substring(0, lastindex);
                first = true;
                lastindex = i;
                break;
              } else if (line[i] == ',') {
                if (line[i] == ',' && third == false) {
                  category = line.substring(i + 1, lastindex);
                  third = true;
                  lastindex = i;
                } else if (line[i] == ',' && second == false) {
                  price = line.substring(i + 1, lastindex);
                  second = true;
                  lastindex = i;
                }
              }
            }
            if (isFirstLine == false)
              myList.add(new SearchModel(description, price, category));
            isFirstLine = false;
          }
          await databaseRepositoryImpl.insertCDM(hospital.hospitalName, myList);
          hospital.isDownload = 2;
          return hospital;
        }
      } on DioError {
        hospital.isDownload = 0;
        return hospital;
      }
    } else {
      hospital.isDownload = 0;
      return hospital;
    }
  }
}
