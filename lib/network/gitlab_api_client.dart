import 'dart:convert';
import 'dart:io';

import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:curativecare/models/download_cdm_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class GitLabApiClient {
  String base_url =
      "https://gitlab.com/api/v4/projects/18885282/repository/tree?ref=branch-with-data&path=CDM/";

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

  Future getCSVFileSize(String url, DownloadFileButtonClick event) async {
    try {
      var response = await http.head(url);
      Map<String, dynamic> map = response.headers;
      double total = double.parse(map['x-gitlab-size']);
      return total;
    } on SocketException {
      event.downloadFileButtonBloc
          .add(DownloadFileButtonError("Network Error"));
      return;
    }
  }

  Future downloadCSVFile(String url, double fileSize,
      DownloadFileButtonClick event, String dirloc) async {
    Dio dio = new Dio();
    String stateName = box.get('state');
    url =
        "https://gitlab.com/Darshpreet2000/lh-toolkit-cost-of-care-app-data-scraper/-/raw/branch-with-data/CDM" +
            "/$stateName/${event.hospitalName}" +
            ".csv";

    event.downloadFileButtonBloc.add(DownloadFileButtonProgress(
        0.0, event.index, event.hospitalName, event.downloadFileButtonBloc));
    try {
      double progress = 0;
      await dio.download(url, dirloc + "${event.hospitalName}" + ".csv",
          onReceiveProgress: (receivedBytes, totalBytes) {
        progress = ((receivedBytes / fileSize));
        event.downloadFileButtonBloc.add(DownloadFileButtonProgress(
            progress * 0.6,
            event.index,
            event.hospitalName,
            event.downloadFileButtonBloc));
      });
    } on DioError {
      event.downloadFileButtonBloc
          .add(DownloadFileButtonError("Network Error"));
    }
  }
}
