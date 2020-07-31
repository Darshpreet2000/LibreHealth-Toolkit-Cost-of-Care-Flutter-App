import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:curativecare/models/download_cdm_model.dart';
import 'package:dio/dio.dart';

import '../main.dart';

class GitLabApiClient {
  String base_url =
      "https://gitlab.com/api/v4/projects/18885282/repository/tree?ref=branch-with-data&path=CDM/";

  Future fetchStatesName() async {
    List<String> States = new List();
    Dio dio = new Dio();
    String url = base_url+"&per_page=100";
    var response;
    try {
      response = await dio.get(url);
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw Exception("Please check your internet connection and try again");
      } else if (DioErrorType.DEFAULT == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('No Internet Connection');
        }
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }

    List<dynamic> responseBody = response.data;
    if (responseBody.length == 0) {
      throw Exception("Problem Connecting to Server, Try Again Later");
    }

    for (int i = 0; i < responseBody.length; i++) {
      Map<String, dynamic> current_hospital = responseBody[i];
      String stateName = current_hospital['name'];
      stateName = stateName.substring(0, stateName.length);
      States.add(stateName);
    }
    return States;
  }

  Future getAvailableCdm(String stateName) async {
    Dio dio = new Dio();

    String url = base_url + stateName + "&per_page=100&page=";
    int i = 1;

    var response;
    try {
      response = await dio.get(url + "1");
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw Exception("Please check your internet connection and try again");
      } else if (DioErrorType.DEFAULT == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('No Internet Connection');
        }
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }

    var headers = response.headers;
    List<dynamic> responseBody = response.data;
    if (responseBody.length == 0) {
      throw Exception("CDMs Not Available For Your Location");
    }
    // responseBody = responseBody.substring(
    //     responseBody.indexOf("[") + 1, responseBody.lastIndexOf("]"));
    var maxLen = headers["x-total-pages"];
    i++;
    while (i <= int.parse(maxLen[0])) {
      try {
        response = await dio.get(url + i.toString());
      } on DioError catch (e) {
        if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
            DioErrorType.CONNECT_TIMEOUT == e.type) {
          throw Exception(
              "Please check your internet connection and try again");
        } else if (DioErrorType.DEFAULT == e.type) {
          if (e.message.contains('SocketException')) {
            throw Exception('No Internet Connection');
          }
        } else {
          throw Exception(
              "Problem connecting to the server. Please try again.");
        }
      }
      responseBody.addAll(response.data);
      i++;
    }

    return responseBody;
  }

  Future<List<DownloadCdmModel>> parseAvailableCdm(
      List<dynamic> elements) async {
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
    BaseOptions options = new BaseOptions(
        connectTimeout: 15 * 1000, // 60 seconds
        receiveTimeout: 15 * 1000 // 60 seconds
        );
    Dio dio = new Dio(options);

    try {
      var response = await dio.head(url);
      Headers map = response.headers;
      double total = double.parse(map.value('x-gitlab-size'));
      return total;
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw Exception("Please check your internet connection and try again");
      } else if (DioErrorType.DEFAULT == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('Please check your internet connection and try again');
        }
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
  }

  Future downloadCSVFile(String url, double fileSize,
      DownloadFileButtonClick event, String dirloc) async {
    BaseOptions options = new BaseOptions(
        connectTimeout: 25 * 1000, // 25 seconds
        receiveTimeout: 25 * 1000 // 25 seconds
        );
    Dio dio = new Dio(options);

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
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw Exception("Please check your internet connection and try again");
      } else if (DioErrorType.DEFAULT == e.type) {
        throw Exception('Please check your internet connection and try again');
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
  }
}
