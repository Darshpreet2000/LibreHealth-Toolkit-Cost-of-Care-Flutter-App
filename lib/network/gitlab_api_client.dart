import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:cost_of_care/models/download_cdm_model.dart';
import 'package:cost_of_care/util/api_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../main.dart';

class GitLabApiClient {
  Dio dio;

  GitLabApiClient(this.dio);

  Future fetchStatesName() async {
    List<String> states = new List();
    ApiConfig apiConfig = new ApiConfig();
    String url = apiConfig.gitlabApiFetchList + "&per_page=100";
    var response;
    try {
      response = await dio.get(url);
    } catch (e) {
      if (e is DioError) {
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
      throw Exception("Problem connecting to the server. Please try again.");
    }

    List<dynamic> responseBody = response.data;
    if (responseBody.length == 0 || response.statusCode != 200) {
      throw Exception("Problem Connecting to Server, Try Again Later");
    }

    for (int i = 0; i < responseBody.length; i++) {
      Map<String, dynamic> currentHospital = responseBody[i];
      String stateName = currentHospital['name'];
      stateName = stateName.substring(0, stateName.length);
      states.add(stateName);
    }
    return states;
  }

  Future getAvailableCdm(String stateName) async {
    ApiConfig apiConfig = new ApiConfig();
    String url =
        apiConfig.gitlabApiFetchList + stateName + "&per_page=100&page=";
    int i = 1;

    var response;
    try {
      response = await dio.get(url + "1");
    } catch (e) {
      if (e is DioError) {
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
      throw Exception("Problem connecting to the server. Please try again.");
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
      } catch (e) {
        if (e is DioError) {
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
        throw Exception("Problem connecting to the server. Please try again.");
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
      Map<String, dynamic> currentHospital = elements[i];
      String hospitalName = currentHospital['name'];
      hospitalName = hospitalName.substring(0, hospitalName.length - 4);
      name.add(DownloadCdmModel(hospitalName, 0));
    }
    return name;
  }

  Future getCSVFileSize(DownloadFileButtonClick event) async {
    String url = ApiConfig().gitlabApiGetCDMFileSize +
        "%2F${event.stateName}%2F${event.hospitalName}" +
        ".csv" +
        "?ref=master";

    try {
      var response = await dio.head(url);
      Headers map = response.headers;
      double total = double.parse(map.value('x-gitlab-size'));
      return total;
    } catch (e) {
      if (e is DioError) {
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
      throw Exception("Problem connecting to the server. Please try again.");
    }
  }

  Future downloadCSVFile(DownloadFileButtonClick event) async {
    String url = ApiConfig().downloadCDMApi +
        "/${event.stateName}/${event.hospitalName}" +
        ".csv";
    //Saving stateName for refreshing
    box.put(event.hospitalName, event.stateName);
    Stream<FileResponse> fileStream;
    //FileStream is handled properly by stream builder. So, testing is not required
    fileStream = DefaultCacheManager().getFileStream(url, withProgress: true);
    return fileStream;
  }
}
